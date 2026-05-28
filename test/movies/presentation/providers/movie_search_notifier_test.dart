import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/error_handler/network_failure.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_provider.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_search_provider.dart';
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

  group('MovieSearchNotifier', () {
    test('given an empty query '
        'when search is called '
        'then state remains empty without triggering a fetch', () {
      // given
      final ProviderContainer container = makeContainer();

      // when
      container.read(movieSearchProvider.notifier).search('  ');

      // then
      final MovieListState state = container.read(movieSearchProvider);
      expect(state.movies, isEmpty);
      expect(state.isLoading, isFalse);
      verifyNever(() => mockRepository.searchMovies(any()));
    });

    test('given a valid query '
        'when the debounce fires '
        'then state contains the search results', () async {
      // given
      when(
        () => mockRepository.searchMovies(any()),
      ).thenAnswer((_) async => (<Movie>[_tMovie()], null));
      final ProviderContainer container = makeContainer();
      container.listen(movieSearchProvider, (_, _) {});

      // when
      container.read(movieSearchProvider.notifier).search('batman');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // then
      final MovieListState state = container.read(movieSearchProvider);
      expect(state.movies.length, 1);
      expect(state.hasError, isFalse);
    });

    test('given a valid query '
        'when the use case returns a failure '
        'then state has error', () async {
      // given
      when(
        () => mockRepository.searchMovies(any()),
      ).thenAnswer((_) async => (null, const NetworkFailure()));
      final ProviderContainer container = makeContainer();
      container.listen(movieSearchProvider, (_, _) {});

      // when
      container.read(movieSearchProvider.notifier).search('batman');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // then
      final MovieListState state = container.read(movieSearchProvider);
      expect(state.hasError, isTrue);
      expect(state.movies, isEmpty);
    });

    test('given a pending search '
        'when clear is called '
        'then the debounce is cancelled and state resets', () {
      // given
      final ProviderContainer container = makeContainer();
      container.read(movieSearchProvider.notifier).search('batman');

      // when
      container.read(movieSearchProvider.notifier).clear();

      // then
      final MovieListState state = container.read(movieSearchProvider);
      expect(state.movies, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.hasError, isFalse);
      verifyNever(() => mockRepository.searchMovies(any()));
    });
  });
}

Movie _tMovie() => const Movie(
  id: 1,
  title: 'Batman',
  originalTitle: 'Batman',
  overview: 'Overview',
  posterPath: 'https://image.tmdb.org/t/p/w500/poster.jpg',
  backdropPath: 'https://image.tmdb.org/t/p/w500/backdrop.jpg',
  releaseDate: '2024-01-01',
  popularity: 100.0,
  voteAverage: 7.5,
  voteCount: 1000,
  genreIds: <int>[28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
