import 'package:json_annotation/json_annotation.dart';

import 'cast_member_model.dart';

part 'movie_credits_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieCreditsResponseModel {
  const MovieCreditsResponseModel({
    required this.id,
    required this.cast,
  });

  factory MovieCreditsResponseModel.fromJson(Map<String, dynamic> json) {
    return _$MovieCreditsResponseModelFromJson(json);
  }

  final int id;
  final List<CastMemberModel> cast;

  Map<String, dynamic> toJson() => _$MovieCreditsResponseModelToJson(this);
}
