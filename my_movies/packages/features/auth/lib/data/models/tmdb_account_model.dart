import 'package:json_annotation/json_annotation.dart';

part 'tmdb_account_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TmdbAccountModel {
  const TmdbAccountModel({
    required this.id,
    required this.username,
    this.name,
  });

  factory TmdbAccountModel.fromJson(Map<String, dynamic> json) {
    return _$TmdbAccountModelFromJson(json);
  }

  final int id;
  final String username;
  final String? name;

  Map<String, dynamic> toJson() => _$TmdbAccountModelToJson(this);
}
