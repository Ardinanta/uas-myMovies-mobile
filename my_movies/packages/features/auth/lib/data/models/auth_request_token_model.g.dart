// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequestTokenModel _$AuthRequestTokenModelFromJson(
  Map<String, dynamic> json,
) => AuthRequestTokenModel(
  success: json['success'] as bool,
  expiresAt: json['expires_at'] as String,
  requestToken: json['request_token'] as String,
);

Map<String, dynamic> _$AuthRequestTokenModelToJson(
  AuthRequestTokenModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'expires_at': instance.expiresAt,
  'request_token': instance.requestToken,
};
