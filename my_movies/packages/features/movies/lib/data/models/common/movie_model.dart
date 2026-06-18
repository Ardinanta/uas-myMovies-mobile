import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieModel {
  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return _$MovieModelFromJson(json);
  }

  final int id;

  @JsonKey(readValue: readTitle)
  final String title;

  @JsonKey(defaultValue: '')
  final String overview;

  @JsonKey(defaultValue: 0)
  final double voteAverage;

  final String? posterPath;

  final String? backdropPath;

  @JsonKey(readValue: readReleaseDate, fromJson: dateFromJson)
  final DateTime? releaseDate;

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      voteAverage: voteAverage,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
    );
  }

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  static Object? readTitle(Map<dynamic, dynamic> json, String key) {
    return json['title'] ?? json['name'] ?? 'Untitled';
  }

  static Object? readReleaseDate(Map<dynamic, dynamic> json, String key) {
    return json['release_date'] ?? json['first_air_date'];
  }

  static DateTime? dateFromJson(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}
