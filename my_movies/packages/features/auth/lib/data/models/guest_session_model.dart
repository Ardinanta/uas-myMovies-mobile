import 'package:json_annotation/json_annotation.dart';

part 'guest_session_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GuestSessionModel {
  const GuestSessionModel({
    required this.success,
    required this.guestSessionId,
    required this.expiresAt,
  });

  factory GuestSessionModel.fromJson(Map<String, dynamic> json) {
    return _$GuestSessionModelFromJson(json);
  }

  final bool success;
  final String guestSessionId;
  final String expiresAt;

  Map<String, dynamic> toJson() => _$GuestSessionModelToJson(this);
}
