import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/failure.dart';
import 'package:remote_content_explorer/features/movies/di/movies_di.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/now_playing_notifier.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  late MockGetNowPlayingMovies mockUseCase;

  setUp(() {
    mockUseCase = MockGetNowPlayingMovies();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [getNowPlayingMoviesProvider.overrideWith((_) => mockUseCase)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('NowPlayingNotifier', () {
    test('given the use case returns movies '
        'when the notifier is initialized '
        'then state contains the loaded movies', () async {
      // given
      when(
        () => mockUseCase.call(page: any(named: 'page')),
      ).thenAnswer((_) async => ([_tMovie()], null));

      // when
      final container = makeContainer();
      container.listen(nowPlayingProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);

      // then
      final state = container.read(nowPlayingProvider);
      expect(state.movies.length, 1);
      expect(state.isLoading, isFalse);
      expect(state.hasError, isFalse);
    });

    test('given the use case returns a failure '
        'when the notifier is initialized '
        'then state has error and no movies', () async {
      // given
      when(
        () => mockUseCase.call(page: any(named: 'page')),
      ).thenAnswer((_) async => (null, const NetworkFailure()));

      // when
      final container = makeContainer();
      container.listen(nowPlayingProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);

      // then
      final state = container.read(nowPlayingProvider);
      expect(state.hasError, isTrue);
      expect(state.movies, isEmpty);
    });

    test('given the notifier is in an error state '
        'when retry is called '
        'then state is refreshed with movies', () async {
      // given — first call fails
      when(
        () => mockUseCase.call(page: any(named: 'page')),
      ).thenAnswer((_) async => (null, const NetworkFailure()));

      final container = makeContainer();
      container.listen(nowPlayingProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);
      expect(container.read(nowPlayingProvider).hasError, isTrue);

      // when — second call succeeds
      when(
        () => mockUseCase.call(page: any(named: 'page')),
      ).thenAnswer((_) async => ([_tMovie()], null));
      await container.read(nowPlayingProvider.notifier).retry();

      // then
      final state = container.read(nowPlayingProvider);
      expect(state.movies.length, 1);
      expect(state.hasError, isFalse);
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
  genreIds: const [28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
