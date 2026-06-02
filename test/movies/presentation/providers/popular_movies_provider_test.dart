import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/errors/failures.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/infrastructure_providers.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/popular_movies_provider.dart';

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

  group('popularMoviesProvider', () {
    test(
      'given the repository returns movies '
      'when the provider is read '
      'then state contains the loaded movies',
      () async {
        when(
          () => mockRepository.getPopular(),
        ).thenAnswer(
          (_) async => Success<List<Movie>>(<Movie>[_tMovie(id: 1)]),
        );

        final ProviderContainer container = makeContainer();
        container.read(popularMoviesProvider);
        await Future<void>.delayed(Duration.zero);

        final AsyncValue<List<Movie>> state = container.read(
          popularMoviesProvider,
        );
        expect(state.value?.length, 1);
        expect(state.hasError, isFalse);
      },
    );

    test(
      'given the repository returns a failure '
      'when the provider is read '
      'then state has error',
      () async {
        when(
          () => mockRepository.getPopular(),
        ).thenAnswer(
          (_) async => const FailureResult<List<Movie>>(ConnectionFailure()),
        );

        final ProviderContainer container = makeContainer();
        container.read(popularMoviesProvider);
        await Future<void>.delayed(Duration.zero);

        expect(container.read(popularMoviesProvider).hasError, isTrue);
      },
    );

    test(
      'given the provider is in an error state '
      'when invalidated '
      'then state is refreshed with movies',
      () async {
        when(
          () => mockRepository.getPopular(),
        ).thenAnswer(
          (_) async => const FailureResult<List<Movie>>(ConnectionFailure()),
        );

        final ProviderContainer container = makeContainer();
        container.read(popularMoviesProvider);
        await Future<void>.delayed(Duration.zero);
        expect(container.read(popularMoviesProvider).hasError, isTrue);

        when(
          () => mockRepository.getPopular(),
        ).thenAnswer(
          (_) async => Success<List<Movie>>(<Movie>[_tMovie(id: 1)]),
        );
        container.invalidate(popularMoviesProvider);
        await container.read(popularMoviesProvider.future);

        expect(container.read(popularMoviesProvider).value?.length, 1);
        expect(container.read(popularMoviesProvider).hasError, isFalse);
      },
    );
  });
}

Movie _tMovie({required int id}) => Movie(
  id: id,
  title: 'Test Movie $id',
  originalTitle: 'Test Movie $id',
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
