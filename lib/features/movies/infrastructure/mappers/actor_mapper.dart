import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';

extension ActorModelMapper on ActorModel {
  Actor toEntity({required String actorImageBaseUrl}) => Actor(
    id: id,
    name: name,
    character: character,
    profilePath: profilePath != null ? '$actorImageBaseUrl$profilePath' : null,
  );
}
