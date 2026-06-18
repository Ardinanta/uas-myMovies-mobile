import 'package:json_annotation/json_annotation.dart';

part 'auth_session_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthSessionModel {
  const AuthSessionModel({
    required this.success,
    required this.sessionId,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return _$AuthSessionModelFromJson(json);
  }

  final bool success;
  final String sessionId;

  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);
}
