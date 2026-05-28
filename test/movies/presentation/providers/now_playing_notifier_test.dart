import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/error_handler/network_failure.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/now_playing_provider.dart';
import 'package:riverpod/src/framework.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  ProviderContainer makeContainer() {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        movieRepositoryProvider.overrideWith((_) => mockRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('nowPlayingProvider', () {
    test('given the repository returns movies '
        'when the provider is read '
        'then state contains the loaded movies', () async {
      // given
      when(
        () => mockRepository.getNowPlaying(),
      ).thenAnswer((_) async => (<Movie>[_tMovie()], null));

      // when
      final ProviderContainer container = makeContainer();
      container.read(nowPlayingProvider);
      await Future<void>.delayed(Duration.zero);

      // then
      final AsyncValue<List<Movie>> state = container.read(nowPlayingProvider);
      expect(state.value?.length, 1);
      expect(state.hasError, isFalse);
    });

    test('given the repository returns a failure '
        'when the provider is read '
        'then state has error', () async {
      // given
      when(
        () => mockRepository.getNowPlaying(),
      ).thenAnswer((_) async => (null, const NetworkFailure()));

      // when
      final ProviderContainer container = makeContainer();
      container.read(nowPlayingProvider);
      await Future<void>.delayed(Duration.zero);

      // then
      expect(container.read(nowPlayingProvider).hasError, isTrue);
    });

    test('given the provider is in an error state '
        'when invalidated '
        'then state is refreshed with movies', () async {
      // given — first call fails
      when(
        () => mockRepository.getNowPlaying(),
      ).thenAnswer((_) async => (null, const NetworkFailure()));

      final ProviderContainer container = makeContainer();
      container.read(nowPlayingProvider);
      await Future<void>.delayed(Duration.zero);
      expect(container.read(nowPlayingProvider).hasError, isTrue);

      // when — retry succeeds
      when(
        () => mockRepository.getNowPlaying(),
      ).thenAnswer((_) async => (<Movie>[_tMovie()], null));
      container.invalidate(nowPlayingProvider);
      await container.read(nowPlayingProvider.future);

      // then
      expect(container.read(nowPlayingProvider).value?.length, 1);
      expect(container.read(nowPlayingProvider).hasError, isFalse);
    });
  });
}

Movie _tMovie({int id = 1}) => Movie(
  id: id,
  title: 'Test Movie',
  originalTitle: 'Test Movie',
  overview: 'Overview',
  posterPath: 'https://image.tmdb.org/t/p/w500/poster.jpg',
  backdropPath: 'https://image.tmdb.org/t/p/w500/backdrop.jpg',
  releaseDate: '2024-01-01',
  popularity: 100.0,
  voteAverage: 7.5,
  voteCount: 1000,
  genreIds: const <int>[28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
