import 'package:movies/movies.dart';

class FavoriteMovie {
  const FavoriteMovie({
    required this.movie,
    this.createdAt,
  });

  final Movie movie;
  final DateTime? createdAt;
}
