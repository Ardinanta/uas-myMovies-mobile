import 'tmdb_api.dart';

abstract class ApiRegistry {
  const ApiRegistry._();

  static const TmdbApi tmdb = TmdbApi();
}
