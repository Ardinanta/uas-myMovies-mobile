// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_genre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieGenreModel _$MovieGenreModelFromJson(Map<String, dynamic> json) =>
    MovieGenreModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$MovieGenreModelToJson(MovieGenreModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
