import 'package:json_annotation/json_annotation.dart';

import 'movie_genre_model.dart';

part 'movie_genre_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieGenreResponseModel {
  const MovieGenreResponseModel({
    required this.genres,
  });

  factory MovieGenreResponseModel.fromJson(Map<String, dynamic> json) {
    return _$MovieGenreResponseModelFromJson(json);
  }

  final List<MovieGenreModel> genres;

  Map<String, dynamic> toJson() => _$MovieGenreResponseModelToJson(this);
}
