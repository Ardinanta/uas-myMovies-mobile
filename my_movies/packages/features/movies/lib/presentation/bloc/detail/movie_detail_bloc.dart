import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie_video.dart';
import '../../../domain/usecases/detail/get_movie_cast.dart';
import '../../../domain/usecases/detail/get_movie_detail.dart';
import '../../../domain/usecases/detail/get_movie_videos.dart';
import '../../../domain/usecases/detail/get_related_movies.dart';
import '../../view_models/home_movie_view_model.dart';
import '../../view_models/movie_detail_view_model.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieCast getMovieCast,
    required GetRelatedMovies getRelatedMovies,
    required GetMovieVideos getMovieVideos,
  }) : _getMovieDetail = getMovieDetail,
       _getMovieCast = getMovieCast,
       _getRelatedMovies = getRelatedMovies,
       _getMovieVideos = getMovieVideos,
       super(const MovieDetailState.initial()) {
    on<MovieDetailStarted>(_onStarted);
    on<MovieDetailRetried>(_onRetried);
  }

  final GetMovieDetail _getMovieDetail;
  final GetMovieCast _getMovieCast;
  final GetRelatedMovies _getRelatedMovies;
  final GetMovieVideos _getMovieVideos;

  Future<void> _onStarted(
    MovieDetailStarted event,
    Emitter<MovieDetailState> emit,
  ) async {
    await _load(event.movieId, emit);
  }

  Future<void> _onRetried(
    MovieDetailRetried event,
    Emitter<MovieDetailState> emit,
  ) async {
    await _load(event.movieId, emit);
  }

  Future<void> _load(int movieId, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(status: MovieDetailStatus.loading));

    final detailResult = await _getMovieDetail(movieId);
    final castResult = await _getMovieCast(movieId);
    final relatedResult = await _getRelatedMovies(movieId: movieId);
    final videosResult = await _getMovieVideos(movieId);

    final failure = detailResult.fold((failure) => failure, (_) => null) ??
        castResult.fold((failure) => failure, (_) => null) ??
        relatedResult.fold((failure) => failure, (_) => null) ??
        videosResult.fold((failure) => failure, (_) => null);

    if (failure != null) {
      emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          message: failure.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: MovieDetailStatus.success,
        movie: MovieDetailViewModel.fromMovie(detailResult.right),
        cast: castResult.right
            .take(8)
            .map(CastMemberViewModel.fromEntity)
            .toList(),
        relatedMovies: relatedResult.right
            .take(8)
            .map(HomeMovieViewModel.fromMovie)
            .toList(),
        trailerUrl: _findTrailer(videosResult.right)?.youtubeUri,
      ),
    );
  }

  MovieVideo? _findTrailer(List<MovieVideo> videos) {
    for (final video in videos) {
      if (video.isYoutubeTrailer) {
        return video;
      }
    }

    for (final video in videos) {
      if (video.youtubeUri != null) {
        return video;
      }
    }

    return null;
  }
}
