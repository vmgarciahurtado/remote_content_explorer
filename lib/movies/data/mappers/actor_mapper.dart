import 'package:remote_content_explorer/movies/data/models/actor_model.dart';
import 'package:remote_content_explorer/movies/domain/entities/actor.dart';

const _actorImageBaseUrl = 'https://image.tmdb.org/t/p/w185';

extension ActorModelMapper on ActorModel {
  Actor toEntity() => Actor(
    id: id,
    name: name,
    character: character,
    profilePath:
        profilePath != null ? '$_actorImageBaseUrl$profilePath' : null,
  );
}
