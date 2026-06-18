import '../../domain/entities/movie_genre.dart';

class MovieGenreViewModel {
  const MovieGenreViewModel({
    required this.id,
    required this.name,
  });

  factory MovieGenreViewModel.fromEntity(MovieGenre genre) {
    return MovieGenreViewModel(id: genre.id, name: genre.name);
  }

  final int id;
  final String name;
}
