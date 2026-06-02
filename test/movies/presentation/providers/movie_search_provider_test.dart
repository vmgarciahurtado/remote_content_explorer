import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/errors/failures.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/infrastructure_providers.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_search_provider.dart';

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

  group('MovieSearchProvider and SearchQueryProvider', () {
    test(
      'given an empty query '
      'when searchQueryProvider changes to empty '
      'then movieSearchProvider remains empty without triggering a fetch',
      () async {
        final ProviderContainer container = makeContainer();

        container.read(searchQueryProvider.notifier).setQuery('  ');
        final List<Movie> value = await container.read(
          movieSearchProvider.future,
        );

        expect(value, isEmpty);
        verifyNever(() => mockRepository.searchMovies(any()));
      },
    );

    test(
      'given a valid query '
      'when the debounce fires '
      'then movieSearchProvider contains the search results',
      () async {
        when(
          () => mockRepository.searchMovies(any()),
        ).thenAnswer((_) async => Success<List<Movie>>(<Movie>[_tMovie()]));
        final ProviderContainer container = makeContainer();

        container.listen(movieSearchProvider, (_, __) {});

        container.read(searchQueryProvider.notifier).setQuery('batman');

        await Future<void>.delayed(const Duration(milliseconds: 500));

        final AsyncValue<List<Movie>> state = container.read(
          movieSearchProvider,
        );
        expect(state.value?.length, 1);
        expect(state.hasError, isFalse);
        verify(() => mockRepository.searchMovies('batman')).called(1);
      },
    );

    test(
      'given a valid query '
      'when the use case returns a failure '
      'then movieSearchProvider has error',
      () async {
        when(
          () => mockRepository.searchMovies(any()),
        ).thenAnswer(
          (_) async => const FailureResult<List<Movie>>(ConnectionFailure()),
        );
        final ProviderContainer container = makeContainer();
        container.listen(movieSearchProvider, (_, __) {});

        container.read(searchQueryProvider.notifier).setQuery('batman');
        await Future<void>.delayed(const Duration(milliseconds: 500));

        final AsyncValue<List<Movie>> state = container.read(
          movieSearchProvider,
        );
        expect(state.hasError, isTrue);
        expect(state.value, isNull);
      },
    );

    test(
      'given a pending search '
      'when query is cleared '
      'then state resets and no fetch is triggered',
      () async {
        final ProviderContainer container = makeContainer();
        container.listen(movieSearchProvider, (_, __) {});
        container.read(searchQueryProvider.notifier).setQuery('batman');

        container.read(searchQueryProvider.notifier).setQuery('');
        final List<Movie> value = await container.read(
          movieSearchProvider.future,
        );

        expect(value, isEmpty);
        verifyNever(() => mockRepository.searchMovies(any()));
      },
    );
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
