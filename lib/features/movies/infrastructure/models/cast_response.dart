import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';

class CastResponse {
  const CastResponse({required this.id, required this.cast});

  final int id;
  final List<ActorModel> cast;

  factory CastResponse.fromJson(Map<String, dynamic> json) => CastResponse(
    id: (json['id'] as num).toInt(),
    cast: (json['cast'] as List<dynamic>)
        .map((dynamic e) => ActorModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
