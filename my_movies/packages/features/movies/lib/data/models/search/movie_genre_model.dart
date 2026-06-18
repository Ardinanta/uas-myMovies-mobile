import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/movie_genre.dart';

part 'movie_genre_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieGenreModel {
  const MovieGenreModel({
    required this.id,
    required this.name,
  });

  factory MovieGenreModel.fromJson(Map<String, dynamic> json) {
    return _$MovieGenreModelFromJson(json);
  }

  final int id;
  final String name;

  MovieGenre toEntity() {
    return MovieGenre(id: id, name: name);
  }

  Map<String, dynamic> toJson() => _$MovieGenreModelToJson(this);
}
