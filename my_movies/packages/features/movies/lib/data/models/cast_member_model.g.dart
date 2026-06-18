// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastMemberModel _$CastMemberModelFromJson(Map<String, dynamic> json) =>
    CastMemberModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      character: json['character'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$CastMemberModelToJson(CastMemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.profilePath,
    };
