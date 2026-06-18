// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideoResponseModel _$MovieVideoResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieVideoResponseModel(
  id: (json['id'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => MovieVideoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieVideoResponseModelToJson(
  MovieVideoResponseModel instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};
