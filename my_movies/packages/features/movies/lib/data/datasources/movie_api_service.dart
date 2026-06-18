import 'package:dio/dio.dart';
import 'package:core_services/core_services.dart';
import 'package:retrofit/retrofit.dart';

import '../models/common/movie_model.dart';
import '../models/common/movie_response_model.dart';
import '../models/detail/movie_credits_response_model.dart';
import '../models/detail/movie_video_response_model.dart';
import '../models/search/movie_genre_response_model.dart';

part 'movie_api_service.g.dart';

@RestApi()
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String? baseUrl}) = _MovieApiService;

  @GET(TmdbApi.nowPlayingMovies)
  Future<MovieResponseModel> getNowPlayingMovies({@Query('page') int page = 1});

  @GET(TmdbApi.trendingMovies)
  Future<MovieResponseModel> getTrendingMovies({@Query('page') int page = 1});

  @GET(TmdbApi.popularMovies)
  Future<MovieResponseModel> getPopularMovies({@Query('page') int page = 1});

  @GET(TmdbApi.topRatedMovies)
  Future<MovieResponseModel> getTopRatedMovies({@Query('page') int page = 1});

  @GET(TmdbApi.upcomingMovies)
  Future<MovieResponseModel> getUpcomingMovies({@Query('page') int page = 1});

  @GET(TmdbApi.movieGenres)
  Future<MovieGenreResponseModel> getMovieGenres();

  @GET(TmdbApi.discoverMovies)
  Future<MovieResponseModel> getMoviesByGenre({
    @Query('with_genres') required int genreId,
    @Query('page') int page = 1,
    @Query('sort_by') String sortBy = 'popularity.desc',
    @Query('include_adult') bool includeAdult = false,
  });

  @GET(TmdbApi.movieDetail)
  Future<MovieModel> getMovieDetail(@Path('movieId') int movieId);

  @GET(TmdbApi.movieCredits)
  Future<MovieCreditsResponseModel> getMovieCredits(
    @Path('movieId') int movieId,
  );

  @GET(TmdbApi.relatedMovies)
  Future<MovieResponseModel> getRelatedMovies({
    @Path('movieId') required int movieId,
    @Query('page') int page = 1,
  });

  @GET(TmdbApi.movieVideos)
  Future<MovieVideoResponseModel> getMovieVideos(@Path('movieId') int movieId);

  @GET(TmdbApi.searchMovies)
  Future<MovieResponseModel> searchMovies({
    @Query('query') required String query,
    @Query('page') int page = 1,
    @Query('include_adult') bool includeAdult = false,
  });
}
