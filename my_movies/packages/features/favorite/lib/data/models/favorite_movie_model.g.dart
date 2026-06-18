// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMovieModel _$FavoriteMovieModelFromJson(Map<String, dynamic> json) =>
    FavoriteMovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$FavoriteMovieModelToJson(FavoriteMovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
