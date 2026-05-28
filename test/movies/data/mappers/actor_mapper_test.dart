import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/actor_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';

void main() {
  group('ActorModelMapper', () {
    test('given an actor with a profile path '
        'when toEntity is called '
        'then the profile URL is prefixed with the actor image base URL', () {
      // given
      const ActorModel model = ActorModel(
        id: 1,
        name: 'John Doe',
        character: 'Hero',
        profilePath: '/profile.jpg',
      );

      // when
      final Actor entity = model.toEntity();

      // then
      expect(entity.profilePath, 'https://image.tmdb.org/t/p/w185/profile.jpg');
    });

    test('given an actor without a profile path '
        'when toEntity is called '
        'then profilePath is null in the entity', () {
      // given
      const ActorModel model = ActorModel(
        id: 1,
        name: 'John Doe',
        character: 'Hero',
        profilePath: null,
      );

      // when
      final Actor entity = model.toEntity();

      // then
      expect(entity.profilePath, isNull);
    });
  });
}
