import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/mappers/remote_actor_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/services/image_url_resolver.dart';

void main() {
  group('RemoteActorMapper.toEntity', () {
    const String tActorImageBaseUrl = 'https://image.tmdb.org/t/p/w185';
    const ImageUrlResolver tResolver = ImageUrlResolver(
      imageBaseUrl: '',
      actorImageBaseUrl: tActorImageBaseUrl,
      noImageUrl: '',
    );

    test(
      'given an actor with a profile path when toEntity is called '
      'then the profile URL is prefixed with the actor image base URL',
      () {
        const RemoteActorModel model = RemoteActorModel(
          id: 1,
          name: 'John Doe',
          character: 'Hero',
          profilePath: '/profile.jpg',
        );

        final Actor entity = RemoteActorMapper.toEntity(model, tResolver);

        expect(
          entity.profilePath,
          'https://image.tmdb.org/t/p/w185/profile.jpg',
        );
      },
    );

    test(
      'given an actor without a profile path when toEntity is called '
      'then profilePath is null in the entity',
      () {
        const RemoteActorModel model = RemoteActorModel(
          id: 1,
          name: 'John Doe',
          character: 'Hero',
          profilePath: null,
        );

        final Actor entity = RemoteActorMapper.toEntity(model, tResolver);

        expect(entity.profilePath, isNull);
      },
    );
  });
}
