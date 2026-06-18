// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: MovieModel.readTitle(json, 'title') as String,
  overview: json['overview'] as String? ?? '',
  voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  releaseDate: MovieModel.dateFromJson(
    MovieModel.readReleaseDate(json, 'release_date') as String?,
  ),
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate?.toIso8601String(),
    };
