import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';

void main() {
  late ProviderContainer container;

  setUpAll(() {
    dotenv.loadFromString(
      envString:
          'API_KEY=test\n'
          'BASE_URL=https://api.test.com/\n'
          'IMAGE_BASE_URL=https://img.test.com/\n'
          'ACTOR_IMAGE_BASE_URL=https://actor.test.com/',
    );
  });

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() => container.dispose());

  group('movies DI providers', () {
    test('given the provider graph '
        'when movieRepositoryProvider is read '
        'then returns a MovieRepository instance', () {
      expect(container.read(movieRepositoryProvider), isA<MovieRepository>());
    });
  });
}
