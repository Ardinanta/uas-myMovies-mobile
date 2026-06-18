import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieResponseModel {
  const MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return _$MovieResponseModelFromJson(json);
  }

  final int page;
  final List<MovieModel> results;

  final int totalPages;

  final int totalResults;

  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}
