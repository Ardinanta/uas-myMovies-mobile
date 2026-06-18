import 'package:json_annotation/json_annotation.dart';

import 'movie_video_model.dart';

part 'movie_video_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieVideoResponseModel {
  const MovieVideoResponseModel({
    required this.id,
    required this.results,
  });

  factory MovieVideoResponseModel.fromJson(Map<String, dynamic> json) {
    return _$MovieVideoResponseModelFromJson(json);
  }

  final int id;
  final List<MovieVideoModel> results;

  Map<String, dynamic> toJson() => _$MovieVideoResponseModelToJson(this);
}
