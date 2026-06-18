import 'package:core_services/core_services.dart';

import '../models/movie_model.dart';
import '../models/movie_response_model.dart';
import 'movie_api_service.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponseModel> getNowPlayingMovies({int page = 1});

  Future<MovieResponseModel> getTrendingMovies({int page = 1});

  Future<MovieResponseModel> getPopularMovies({int page = 1});

  Future<MovieResponseModel> getTopRatedMovies({int page = 1});

  Future<MovieResponseModel> getUpcomingMovies({int page = 1});

  Future<MovieModel> getMovieDetail(int movieId);

  Future<MovieResponseModel> searchMovies({
    required String query,
    int page = 1,
  });

  Future<MovieResponseModel> getFavoriteMovies({int page = 1});

  Future<MovieResponseModel> getFavoriteTv({int page = 1});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  MovieRemoteDataSourceImpl({
    required DioClient dioClient,
    MovieApiService? apiService,
  }) : _apiService = apiService ?? MovieApiService(dioClient.raw);

  final MovieApiService _apiService;

  @override
  Future<MovieResponseModel> getNowPlayingMovies({int page = 1}) {
    return _apiService.getNowPlayingMovies(page: page);
  }

  @override
  Future<MovieResponseModel> getTrendingMovies({int page = 1}) {
    return _apiService.getTrendingMovies(page: page);
  }

  @override
  Future<MovieResponseModel> getPopularMovies({int page = 1}) {
    return _apiService.getPopularMovies(page: page);
  }

  @override
  Future<MovieResponseModel> getTopRatedMovies({int page = 1}) {
    return _apiService.getTopRatedMovies(page: page);
  }

  @override
  Future<MovieResponseModel> getUpcomingMovies({int page = 1}) {
    return _apiService.getUpcomingMovies(page: page);
  }

  @override
  Future<MovieModel> getMovieDetail(int movieId) {
    return _apiService.getMovieDetail(movieId);
  }

  @override
  Future<MovieResponseModel> searchMovies({
    required String query,
    int page = 1,
  }) {
    return _apiService.searchMovies(query: query, page: page);
  }

  @override
  Future<MovieResponseModel> getFavoriteMovies({int page = 1}) {
    return _apiService.getFavoriteMovies(
      accountId: TmdbConstants.accountId,
      sessionId: TmdbConstants.sessionId,
      page: page,
    );
  }

  @override
  Future<MovieResponseModel> getFavoriteTv({int page = 1}) {
    return _apiService.getFavoriteTv(
      accountId: TmdbConstants.accountId,
      sessionId: TmdbConstants.sessionId,
      page: page,
    );
  }
}
