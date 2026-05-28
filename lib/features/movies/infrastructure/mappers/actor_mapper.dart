import 'package:remote_content_explorer/core/constants/env.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';

extension ActorModelMapper on ActorModel {
  Actor toEntity() => Actor(
    id: id,
    name: name,
    character: character,
    profilePath:
        profilePath != null ? '${Env.actorImageBaseUrl}$profilePath' : null,
  );
}
