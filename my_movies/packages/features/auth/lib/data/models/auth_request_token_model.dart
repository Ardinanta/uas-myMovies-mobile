import 'package:json_annotation/json_annotation.dart';

part 'auth_request_token_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthRequestTokenModel {
  const AuthRequestTokenModel({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  factory AuthRequestTokenModel.fromJson(Map<String, dynamic> json) {
    return _$AuthRequestTokenModelFromJson(json);
  }

  final bool success;
  final String expiresAt;
  final String requestToken;

  Map<String, dynamic> toJson() => _$AuthRequestTokenModelToJson(this);
}
