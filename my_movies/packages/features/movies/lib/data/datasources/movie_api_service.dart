import 'package:dio/dio.dart';
import 'package:core_services/core_services.dart';
import 'package:retrofit/retrofit.dart';

import '../models/movie_model.dart';
import '../models/movie_response_model.dart';

part 'movie_api_service.g.dart';

@RestApi()
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String? baseUrl}) = _MovieApiService;

  @GET(TmdbApi.nowPlayingMovies)
  Future<MovieResponseModel> getNowPlayingMovies({
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.trendingMovies)
  Future<MovieResponseModel> getTrendingMovies({
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.popularMovies)
  Future<MovieResponseModel> getPopularMovies({
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.topRatedMovies)
  Future<MovieResponseModel> getTopRatedMovies({
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.upcomingMovies)
  Future<MovieResponseModel> getUpcomingMovies({
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.movieDetail)
  Future<MovieModel> getMovieDetail(@Path('movieId') int movieId);

  @GET(TmdbApi.searchMovies)
  Future<MovieResponseModel> searchMovies({
    @Query('query') required String query,
    @Query('page') int page = 1,
    @Query('include_adult') bool includeAdult = false,
  });

  @GET(TmdbApi.favoriteMovies)
  Future<MovieResponseModel> getFavoriteMovies({
    @Path('accountId') required String accountId,
    @Query('session_id') required String sessionId,
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.favoriteTv)
  Future<MovieResponseModel> getFavoriteTv({
    @Path('accountId') required String accountId,
    @Query('session_id') required String sessionId,
    @Query('page') int page = 1,
  });
}
