import 'package:json_annotation/json_annotation.dart';

part 'auth_create_session_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AuthCreateSessionRequestModel {
  const AuthCreateSessionRequestModel({
    required this.requestToken,
  });

  final String requestToken;

  Map<String, dynamic> toJson() {
    return _$AuthCreateSessionRequestModelToJson(this);
  }
}
