import 'package:json_annotation/json_annotation.dart';

part 'auth_delete_session_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AuthDeleteSessionRequestModel {
  const AuthDeleteSessionRequestModel({
    required this.sessionId,
  });

  final String sessionId;

  Map<String, dynamic> toJson() {
    return _$AuthDeleteSessionRequestModelToJson(this);
  }
}
