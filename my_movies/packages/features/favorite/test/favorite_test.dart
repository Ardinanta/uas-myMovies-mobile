import 'package:flutter_test/flutter_test.dart';

import 'package:favorite/favorite.dart';
import 'package:movies/movies.dart';

void main() {
  test('creates favorite movie entity', () {
    const movie = Movie(
      id: 1,
      title: 'Neon Genesis',
      overview: 'A favorite movie.',
      voteAverage: 8.4,
    );

    const favorite = FavoriteMovie(movie: movie);

    expect(favorite.movie.id, 1);
    expect(favorite.movie.title, 'Neon Genesis');
  });
}
