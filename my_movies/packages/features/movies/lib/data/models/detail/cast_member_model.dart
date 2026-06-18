import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/cast_member.dart';

part 'cast_member_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CastMemberModel {
  const CastMemberModel({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) {
    return _$CastMemberModelFromJson(json);
  }

  final int id;
  final String name;

  @JsonKey(defaultValue: '')
  final String character;

  final String? profilePath;

  CastMember toEntity() {
    return CastMember(
      id: id,
      name: name,
      character: character,
      profilePath: profilePath,
    );
  }

  Map<String, dynamic> toJson() => _$CastMemberModelToJson(this);
}
