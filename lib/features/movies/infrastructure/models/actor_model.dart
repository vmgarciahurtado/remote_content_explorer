import 'package:json_annotation/json_annotation.dart';

part 'actor_model.g.dart';

@JsonSerializable(createToJson: false)
class ActorModel {
  const ActorModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  final int id;
  final String name;
  @JsonKey(defaultValue: '')
  final String character;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  factory ActorModel.fromJson(Map<String, dynamic> json) =>
      _$ActorModelFromJson(json);
}
