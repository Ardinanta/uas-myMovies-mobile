// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    AuthSessionModel(
      success: json['success'] as bool,
      sessionId: json['session_id'] as String,
    );

Map<String, dynamic> _$AuthSessionModelToJson(AuthSessionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'session_id': instance.sessionId,
    };
