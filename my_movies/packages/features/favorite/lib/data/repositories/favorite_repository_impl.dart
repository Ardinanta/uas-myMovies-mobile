import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';
import 'package:movies/movies.dart';

import '../../domain/entities/favorite_movie.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_data_source.dart';
import '../models/favorite_movie_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  const FavoriteRepositoryImpl(this._localDataSource);

  final FavoriteLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<FavoriteMovie>>> getFavoriteMovies({
    int page = 1,
  }) async {
    try {
      final movies = await _localDataSource.getFavoriteMovies();
      final sortedMovies = [...movies]
        ..sort((a, b) {
          final aCreatedAt = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          final bCreatedAt = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          return bCreatedAt.compareTo(aCreatedAt);
        });

      return Right(sortedMovies.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int movieId) async {
    try {
      final movies = await _localDataSource.getFavoriteMovies();
      return Right(movies.any((movie) => movie.id == movieId));
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Movie movie) async {
    try {
      final movies = await _localDataSource.getFavoriteMovies();
      final existingIndex = movies.indexWhere((item) => item.id == movie.id);
      final favoriteMovie = FavoriteMovieModel.fromMovie(movie);

      final updatedMovies = [...movies];
      if (existingIndex == -1) {
        updatedMovies.add(favoriteMovie);
      } else {
        updatedMovies[existingIndex] = favoriteMovie;
      }

      await _localDataSource.saveFavoriteMovies(updatedMovies);
      return const Right(null);
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int movieId) async {
    try {
      final movies = await _localDataSource.getFavoriteMovies();
      final updatedMovies = movies
          .where((movie) => movie.id != movieId)
          .toList(growable: false);

      await _localDataSource.saveFavoriteMovies(updatedMovies);
      return const Right(null);
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(Movie movie) async {
    try {
      final movies = await _localDataSource.getFavoriteMovies();
      final isAlreadyFavorite = movies.any((item) => item.id == movie.id);

      if (isAlreadyFavorite) {
        final updatedMovies = movies
            .where((item) => item.id != movie.id)
            .toList(growable: false);
        await _localDataSource.saveFavoriteMovies(updatedMovies);
        return const Right(false);
      }

      await _localDataSource.saveFavoriteMovies([
        ...movies,
        FavoriteMovieModel.fromMovie(movie),
      ]);
      return const Right(true);
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }
}
