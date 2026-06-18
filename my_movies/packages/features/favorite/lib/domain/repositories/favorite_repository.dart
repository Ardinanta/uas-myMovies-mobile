import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';
import 'package:movies/movies.dart';

import '../entities/favorite_movie.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<FavoriteMovie>>> getFavoriteMovies({
    int page = 1,
  });

  Future<Either<Failure, bool>> isFavorite(int movieId);

  Future<Either<Failure, void>> addFavorite(Movie movie);

  Future<Either<Failure, void>> removeFavorite(int movieId);

  Future<Either<Failure, bool>> toggleFavorite(Movie movie);
}
