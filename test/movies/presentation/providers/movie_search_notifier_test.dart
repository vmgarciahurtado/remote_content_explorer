import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/failure.dart';
import 'package:remote_content_explorer/features/movies/di/movies_di.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/search_movies.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_search_notifier.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late MockSearchMovies mockUseCase;

  setUp(() {
    mockUseCase = MockSearchMovies();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [searchMoviesProvider.overrideWith((_) => mockUseCase)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('MovieSearchNotifier', () {
    test('given an empty query '
        'when search is called '
        'then state remains empty without triggering a fetch', () {
      // given
      final container = makeContainer();

      // when
      container.read(movieSearchProvider.notifier).search('  ');

      // then
      final state = container.read(movieSearchProvider);
      expect(state.movies, isEmpty);
      expect(state.isLoading, isFalse);
      verifyNever(() => mockUseCase.call(any()));
    });

    test('given a valid query '
        'when the debounce fires '
        'then state contains the search results', () async {
      // given
      when(
        () => mockUseCase.call(any()),
      ).thenAnswer((_) async => Right([_tMovie()]));
      final container = makeContainer();
      container.listen(movieSearchProvider, (_, _) {});

      // when
      container.read(movieSearchProvider.notifier).search('batman');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // then
      final state = container.read(movieSearchProvider);
      expect(state.movies.length, 1);
      expect(state.hasError, isFalse);
    });

    test('given a valid query '
        'when the use case returns a failure '
        'then state has error', () async {
      // given
      when(
        () => mockUseCase.call(any()),
      ).thenAnswer((_) async => const Left(NetworkFailure()));
      final container = makeContainer();
      container.listen(movieSearchProvider, (_, _) {});

      // when
      container.read(movieSearchProvider.notifier).search('batman');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // then
      final state = container.read(movieSearchProvider);
      expect(state.hasError, isTrue);
      expect(state.movies, isEmpty);
    });

    test('given a pending search '
        'when clear is called '
        'then the debounce is cancelled and state resets', () {
      // given
      final container = makeContainer();
      container.read(movieSearchProvider.notifier).search('batman');

      // when
      container.read(movieSearchProvider.notifier).clear();

      // then
      final state = container.read(movieSearchProvider);
      expect(state.movies, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.hasError, isFalse);
      verifyNever(() => mockUseCase.call(any()));
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
  genreIds: [28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
