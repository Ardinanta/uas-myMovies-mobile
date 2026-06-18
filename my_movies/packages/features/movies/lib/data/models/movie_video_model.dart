import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_video.dart';

part 'movie_video_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieVideoModel {
  const MovieVideoModel({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.type,
  });

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) {
    return _$MovieVideoModelFromJson(json);
  }

  final String id;
  final String name;
  final String key;
  final String site;
  final String type;

  MovieVideo toEntity() {
    return MovieVideo(
      id: id,
      name: name,
      key: key,
      site: site,
      type: type,
    );
  }

  Map<String, dynamic> toJson() => _$MovieVideoModelToJson(this);
}
