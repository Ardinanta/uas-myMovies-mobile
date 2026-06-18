import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../../entities/cast_member.dart';
import '../../repositories/movie_repository.dart';

class GetMovieCast {
  const GetMovieCast(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, List<CastMember>>> call(int movieId) {
    return _repository.getMovieCast(movieId);
  }
}
