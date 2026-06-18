// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideoModel _$MovieVideoModelFromJson(Map<String, dynamic> json) =>
    MovieVideoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$MovieVideoModelToJson(MovieVideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'type': instance.type,
    };
