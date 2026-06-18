// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_genre_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieGenreResponseModel _$MovieGenreResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieGenreResponseModel(
  genres: (json['genres'] as List<dynamic>)
      .map((e) => MovieGenreModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieGenreResponseModelToJson(
  MovieGenreResponseModel instance,
) => <String, dynamic>{'genres': instance.genres};
