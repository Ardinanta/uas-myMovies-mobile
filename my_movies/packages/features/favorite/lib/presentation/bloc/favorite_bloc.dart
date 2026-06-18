import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_favorite_movies.dart';
import '../../domain/usecases/remove_favorite_movie.dart';
import '../view_models/favorite_movie_view_model.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({
    required GetFavoriteMovies getFavoriteMovies,
    required RemoveFavoriteMovie removeFavoriteMovie,
  }) : _getFavoriteMovies = getFavoriteMovies,
       _removeFavoriteMovie = removeFavoriteMovie,
       super(const FavoriteState.initial()) {
    on<FavoriteStarted>(_onStarted);
    on<FavoriteRetried>(_onStarted);
    on<FavoriteMovieRemoved>(_onMovieRemoved);
  }

  final GetFavoriteMovies _getFavoriteMovies;
  final RemoveFavoriteMovie _removeFavoriteMovie;

  Future<void> _onStarted(
    FavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _onMovieRemoved(
    FavoriteMovieRemoved event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await _removeFavoriteMovie(event.movieId);

    if (result.isLeft) {
      emit(
        state.copyWith(
          status: FavoriteStatus.failure,
          message: result.left.message,
        ),
      );
      return;
    }

    await _load(emit, showLoading: false);
  }

  Future<void> _load(
    Emitter<FavoriteState> emit, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      emit(state.copyWith(status: FavoriteStatus.loading, message: null));
    }

    final result = await _getFavoriteMovies();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: FavoriteStatus.failure,
            message: failure.message,
          ),
        );
      },
      (movies) {
        final viewModels = movies
            .map(FavoriteMovieViewModel.fromEntity)
            .toList();

        emit(
          state.copyWith(
            status: viewModels.isEmpty
                ? FavoriteStatus.empty
                : FavoriteStatus.success,
            movies: viewModels,
            message: null,
          ),
        );
      },
    );
  }
}
