import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/home/get_popular_movies.dart';
import '../../../domain/usecases/home/get_trending_movies.dart';
import '../../../domain/usecases/search/get_movie_genres.dart';
import '../../../domain/usecases/search/get_movies_by_genre.dart';
import '../../../domain/usecases/search/search_movies.dart';
import '../../view_models/home_movie_view_model.dart';
import '../../view_models/movie_genre_view_model.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required GetTrendingMovies getTrendingMovies,
    required GetPopularMovies getPopularMovies,
    required GetMovieGenres getMovieGenres,
    required GetMoviesByGenre getMoviesByGenre,
    required SearchMovies searchMovies,
  }) : _getTrendingMovies = getTrendingMovies,
       _getPopularMovies = getPopularMovies,
       _getMovieGenres = getMovieGenres,
       _getMoviesByGenre = getMoviesByGenre,
       _searchMovies = searchMovies,
       super(const SearchState.initial()) {
    on<SearchStarted>(_onStarted);
    on<SearchRetried>(_onStarted);
    on<SearchSubmitted>(_onSubmitted);
    on<SearchCleared>(_onCleared);
    on<SearchGenreSelected>(_onGenreSelected);
    on<SearchRecommendationsRequested>(_onRecommendationsRequested);
  }

  final GetTrendingMovies _getTrendingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetMovieGenres _getMovieGenres;
  final GetMoviesByGenre _getMoviesByGenre;
  final SearchMovies _searchMovies;
  int _requestVersion = 0;

  Future<void> _onStarted(
    SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    final requestVersion = ++_requestVersion;
    emit(state.copyWith(status: SearchStatus.loading, message: null));

    final trendingResult = await _getTrendingMovies();
    final popularResult = await _getPopularMovies();
    final genreResult = await _getMovieGenres();

    if (requestVersion != _requestVersion) {
      return;
    }

    final failure = trendingResult.fold((failure) => failure, (_) => null) ??
        popularResult.fold((failure) => failure, (_) => null) ??
        genreResult.fold((failure) => failure, (_) => null);

    if (failure != null) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: failure.message,
        ),
      );
      return;
    }

    final genres = genreResult.right
        .take(6)
        .map(MovieGenreViewModel.fromEntity)
        .toList();
    final previewMovies = <int, List<HomeMovieViewModel>>{};

    for (final genre in genres.take(4)) {
      final result = await _getMoviesByGenre(genreId: genre.id);
      if (requestVersion != _requestVersion) {
        return;
      }
      if (result.isRight) {
        previewMovies[genre.id] = result.right
            .take(2)
            .map(HomeMovieViewModel.fromMovie)
            .toList();
      }
    }

    emit(
      state.copyWith(
        status: SearchStatus.success,
        query: '',
        contentMode: SearchContentMode.overview,
        activeTitle: null,
        trendingMovies: trendingResult.right
            .take(8)
            .map(HomeMovieViewModel.fromMovie)
            .toList(),
        recommendations: popularResult.right
            .map(HomeMovieViewModel.fromMovie)
            .toList(),
        genres: genres,
        genrePreviewMovies: previewMovies,
        searchResults: const [],
      ),
    );
  }

  Future<void> _onSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    final requestVersion = ++_requestVersion;
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          query: '',
          contentMode: SearchContentMode.overview,
          activeTitle: null,
          searchResults: const [],
          message: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SearchStatus.loading,
        query: query,
        contentMode: SearchContentMode.query,
        activeTitle: 'Hasil Pencarian',
        message: null,
      ),
    );

    final result = await _searchMovies(query: query);

    if (requestVersion != _requestVersion) {
      return;
    }

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: SearchStatus.failure,
            message: failure.message,
            contentMode: SearchContentMode.query,
            activeTitle: 'Hasil Pencarian',
          ),
        );
      },
      (movies) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            query: query,
            contentMode: SearchContentMode.query,
            activeTitle: 'Hasil Pencarian',
            searchResults: movies.map(HomeMovieViewModel.fromMovie).toList(),
            message: null,
          ),
        );
      },
    );
  }

  void _onCleared(SearchCleared event, Emitter<SearchState> emit) {
    _requestVersion++;
    emit(
      state.copyWith(
        query: '',
        contentMode: SearchContentMode.overview,
        activeTitle: null,
        searchResults: const [],
        message: null,
        status: SearchStatus.success,
      ),
    );
  }

  Future<void> _onGenreSelected(
    SearchGenreSelected event,
    Emitter<SearchState> emit,
  ) async {
    final requestVersion = ++_requestVersion;
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        query: '',
        contentMode: SearchContentMode.genre,
        activeTitle: event.genreName,
        searchResults: const [],
        message: null,
      ),
    );

    final result = await _getMoviesByGenre(genreId: event.genreId);

    if (requestVersion != _requestVersion) {
      return;
    }

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: SearchStatus.failure,
            contentMode: SearchContentMode.genre,
            activeTitle: event.genreName,
            message: failure.message,
          ),
        );
      },
      (movies) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            contentMode: SearchContentMode.genre,
            activeTitle: event.genreName,
            searchResults: movies.map(HomeMovieViewModel.fromMovie).toList(),
            message: null,
          ),
        );
      },
    );
  }

  void _onRecommendationsRequested(
    SearchRecommendationsRequested event,
    Emitter<SearchState> emit,
  ) {
    _requestVersion++;
    emit(
      state.copyWith(
        status: SearchStatus.success,
        query: '',
        contentMode: SearchContentMode.recommendations,
        activeTitle: 'Rekomendasi',
        searchResults: state.recommendations,
        message: null,
      ),
    );
  }
}
