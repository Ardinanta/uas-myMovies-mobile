import '../../view_models/home_movie_view_model.dart';
import '../../view_models/movie_genre_view_model.dart';

enum SearchStatus {
  initial,
  loading,
  success,
  failure,
}

enum SearchContentMode {
  overview,
  query,
  genre,
  recommendations,
}

class SearchState {
  const SearchState({
    required this.status,
    this.query = '',
    this.trendingMovies = const [],
    this.genres = const [],
    this.genrePreviewMovies = const {},
    this.recommendations = const [],
    this.searchResults = const [],
    this.contentMode = SearchContentMode.overview,
    this.activeTitle,
    this.message,
  });

  const SearchState.initial() : this(status: SearchStatus.initial);

  final SearchStatus status;
  final String query;
  final List<HomeMovieViewModel> trendingMovies;
  final List<MovieGenreViewModel> genres;
  final Map<int, List<HomeMovieViewModel>> genrePreviewMovies;
  final List<HomeMovieViewModel> recommendations;
  final List<HomeMovieViewModel> searchResults;
  final SearchContentMode contentMode;
  final String? activeTitle;
  final String? message;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<HomeMovieViewModel>? trendingMovies,
    List<MovieGenreViewModel>? genres,
    Map<int, List<HomeMovieViewModel>>? genrePreviewMovies,
    List<HomeMovieViewModel>? recommendations,
    List<HomeMovieViewModel>? searchResults,
    SearchContentMode? contentMode,
    String? activeTitle,
    String? message,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      genres: genres ?? this.genres,
      genrePreviewMovies: genrePreviewMovies ?? this.genrePreviewMovies,
      recommendations: recommendations ?? this.recommendations,
      searchResults: searchResults ?? this.searchResults,
      contentMode: contentMode ?? this.contentMode,
      activeTitle: activeTitle,
      message: message,
    );
  }
}
