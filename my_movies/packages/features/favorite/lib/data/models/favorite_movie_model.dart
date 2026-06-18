import 'package:json_annotation/json_annotation.dart';
import 'package:movies/movies.dart';

import '../../domain/entities/favorite_movie.dart';

part 'favorite_movie_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FavoriteMovieModel {
  const FavoriteMovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.createdAt,
  });

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) {
    return _$FavoriteMovieModelFromJson(json);
  }

  factory FavoriteMovieModel.fromMovie(Movie movie, {DateTime? createdAt}) {
    return FavoriteMovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      voteAverage: movie.voteAverage,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      releaseDate: movie.releaseDate,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final String? posterPath;
  final String? backdropPath;
  final DateTime? releaseDate;
  final DateTime? createdAt;

  FavoriteMovie toEntity() {
    return FavoriteMovie(
      movie: Movie(
        id: id,
        title: title,
        overview: overview,
        voteAverage: voteAverage,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
      ),
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => _$FavoriteMovieModelToJson(this);
}
