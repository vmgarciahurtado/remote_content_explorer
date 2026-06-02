import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/services/image_url_resolver.dart';

class RemoteActorMapper {
  const RemoteActorMapper._();

  static Actor toEntity(RemoteActorModel model, ImageUrlResolver resolver) =>
      Actor(
        id: model.id,
        name: model.name,
        character: model.character,
        profilePath: resolver.actorImage(model.profilePath),
      );
}
