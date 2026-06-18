import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMovies {
  const SearchMovies(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, List<Movie>>> call({
    required String query,
    int page = 1,
  }) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return Future.value(const Right([]));
    }

    return _repository.searchMovies(query: trimmedQuery, page: page);
  }
}
