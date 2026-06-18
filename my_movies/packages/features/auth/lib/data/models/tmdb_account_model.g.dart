// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbAccountModel _$TmdbAccountModelFromJson(Map<String, dynamic> json) =>
    TmdbAccountModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TmdbAccountModelToJson(TmdbAccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
    };
