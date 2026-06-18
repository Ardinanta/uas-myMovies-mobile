// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_credits_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCreditsResponseModel _$MovieCreditsResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieCreditsResponseModel(
  id: (json['id'] as num).toInt(),
  cast: (json['cast'] as List<dynamic>)
      .map((e) => CastMemberModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieCreditsResponseModelToJson(
  MovieCreditsResponseModel instance,
) => <String, dynamic>{'id': instance.id, 'cast': instance.cast};
