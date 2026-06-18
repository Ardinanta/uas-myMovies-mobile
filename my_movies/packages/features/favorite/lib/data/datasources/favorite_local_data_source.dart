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

  static const String _favoritesKeyPrefix = 'favorite_movies';

  @override
  Future<List<FavoriteMovieModel>> getFavoriteMovies() async {
    final rawFavorites = await _storage.getString(await _favoritesKey());
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
    return _saveFavorites(encoded);
  }

  Future<void> _saveFavorites(String encoded) async {
    await _storage.saveString(await _favoritesKey(), encoded);
  }

  Future<String> _favoritesKey() async {
    final isGuest = await _storage.getString(AuthStorageKeys.isGuest);
    final accountId = await _storage.getString(AuthStorageKeys.accountId);
    final sessionId = await _storage.getString(AuthStorageKeys.sessionId);

    if (isGuest == 'true' && sessionId != null && sessionId.trim().isNotEmpty) {
      return '${_favoritesKeyPrefix}_guest_${sessionId.trim()}';
    }

    if (accountId != null && accountId.trim().isNotEmpty) {
      return '${_favoritesKeyPrefix}_account_${accountId.trim()}';
    }

    return '${_favoritesKeyPrefix}_anonymous';
  }
}
