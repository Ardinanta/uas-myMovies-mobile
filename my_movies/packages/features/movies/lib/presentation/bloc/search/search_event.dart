sealed class SearchEvent {
  const SearchEvent();
}

class SearchStarted extends SearchEvent {
  const SearchStarted();
}

class SearchRetried extends SearchEvent {
  const SearchRetried();
}

class SearchSubmitted extends SearchEvent {
  const SearchSubmitted(this.query);

  final String query;
}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}

class SearchGenreSelected extends SearchEvent {
  const SearchGenreSelected({
    required this.genreId,
    required this.genreName,
  });

  final int genreId;
  final String genreName;
}

class SearchRecommendationsRequested extends SearchEvent {
  const SearchRecommendationsRequested();
}
