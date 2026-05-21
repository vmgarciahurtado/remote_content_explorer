import 'package:json_annotation/json_annotation.dart';
import 'package:remote_content_explorer/movies/data/models/actor_model.dart';

part 'cast_response.g.dart';

@JsonSerializable(createToJson: false)
class CastResponse {
  const CastResponse({
    required this.id,
    required this.cast,
  });

  final int id;
  final List<ActorModel> cast;

  factory CastResponse.fromJson(Map<String, dynamic> json) =>
      _$CastResponseFromJson(json);
}
