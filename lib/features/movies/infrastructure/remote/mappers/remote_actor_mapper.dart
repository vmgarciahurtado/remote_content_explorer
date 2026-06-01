import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_cast_response.dart';

class RemoteActorMapper {
  static RemoteActorModel actorModelFromJson(Map<String, dynamic> json) =>
      RemoteActorModel(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String,
        character: json['character'] as String? ?? '',
        profilePath: json['profile_path'] as String?,
      );

  static RemoteCastResponse castResponseFromJson(Map<String, dynamic> json) =>
      RemoteCastResponse(
        id: (json['id'] as num).toInt(),
        cast: (json['cast'] as List<dynamic>)
            .map((dynamic e) => actorModelFromJson(e as Map<String, dynamic>))
            .toList(),
      );

  static Actor toEntity(
    RemoteActorModel model, {
    required String actorImageBaseUrl,
  }) =>
      Actor(
        id: model.id,
        name: model.name,
        character: model.character,
        profilePath: model.profilePath != null
            ? '$actorImageBaseUrl${model.profilePath}'
            : null,
      );
}
