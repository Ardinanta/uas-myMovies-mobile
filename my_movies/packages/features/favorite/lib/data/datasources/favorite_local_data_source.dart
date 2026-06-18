import 'dart:convert';

import 'package:core_services/core_services.dart';

import '../models/favorite_movie_model.dart';

abstract class FavoriteLocalDataSource {
  Future<List<FavoriteMovieModel>> getFavoriteMovies();

  Future<void> saveFavoriteMovies(List<FavoriteMovieModel> movies);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  const FavoriteLocalDataSourceImpl(this._storage);

  final LocalStorageService _storage;

  static const String _favoritesKey = 'favorite_movies';

  @override
  Future<List<FavoriteMovieModel>> getFavoriteMovies() async {
    final rawFavorites = await _storage.getString(_favoritesKey);
    if (rawFavorites == null || rawFavorites.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(rawFavorites);
      if (decoded is! List) {
        throw const FormatException('Favorite movies should be a list.');
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(FavoriteMovieModel.fromJson)
          .toList();
    } on FormatException catch (error) {
      throw CacheException(error.message);
    }
  }

  @override
  Future<void> saveFavoriteMovies(List<FavoriteMovieModel> movies) {
    final encoded = jsonEncode(
      movies.map((movie) => movie.toJson()).toList(),
    );
    return _storage.saveString(_favoritesKey, encoded);
  }
}
