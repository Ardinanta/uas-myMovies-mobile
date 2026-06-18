import 'package:json_annotation/json_annotation.dart';

part 'auth_validate_login_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AuthValidateLoginRequestModel {
  const AuthValidateLoginRequestModel({
    required this.username,
    required this.password,
    required this.requestToken,
  });

  final String username;
  final String password;
  final String requestToken;

  Map<String, dynamic> toJson() {
    return _$AuthValidateLoginRequestModelToJson(this);
  }
}
