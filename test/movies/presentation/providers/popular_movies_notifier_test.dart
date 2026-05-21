import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/failure.dart';
import 'package:remote_content_explorer/movies/di/movies_di.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/movies/presentation/providers/popular_movies_notifier.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockUseCase;

  setUp(() {
    mockUseCase = MockGetPopularMovies();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        getPopularMoviesProvider.overrideWith((_) => mockUseCase),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('PopularMoviesNotifier', () {
    test(
      'given the use case returns movies '
      'when the notifier is initialized '
      'then state contains the loaded movies',
      () async {
        // given
        when(() => mockUseCase.call(page: any(named: 'page')))
            .thenAnswer((_) async => Right([_tMovie(id: 1)]));

        // when
        final container = makeContainer();
        container.listen(popularMoviesProvider, (_, _) {});
        await Future<void>.delayed(Duration.zero);

        // then
        final state = container.read(popularMoviesProvider);
        expect(state.movies.length, 1);
        expect(state.isLoading, isFalse);
        expect(state.hasError, isFalse);
      },
    );

    test(
      'given the first page is loaded '
      'when loadNextPage is called '
      'then the second page is appended to the list',
      () async {
        // given
        when(() => mockUseCase.call(page: 1))
            .thenAnswer((_) async => Right([_tMovie(id: 1)]));
        when(() => mockUseCase.call(page: 2))
            .thenAnswer((_) async => Right([_tMovie(id: 2)]));

        final container = makeContainer();
        container.listen(popularMoviesProvider, (_, _) {});
        await Future<void>.delayed(Duration.zero);
        expect(container.read(popularMoviesProvider).movies.length, 1);

        // when
        await container.read(popularMoviesProvider.notifier).loadNextPage();

        // then
        final state = container.read(popularMoviesProvider);
        expect(state.movies.length, 2);
        expect(state.movies.map((m) => m.id), containsAll([1, 2]));
      },
    );

    test(
      'given the notifier is in an error state '
      'when retry is called '
      'then state is refreshed with movies',
      () async {
        // given — first call fails
        when(() => mockUseCase.call(page: any(named: 'page')))
            .thenAnswer((_) async => const Left(NetworkFailure()));

        final container = makeContainer();
        container.listen(popularMoviesProvider, (_, _) {});
        await Future<void>.delayed(Duration.zero);
        expect(container.read(popularMoviesProvider).hasError, isTrue);

        // when — retry succeeds
        when(() => mockUseCase.call(page: any(named: 'page')))
            .thenAnswer((_) async => Right([_tMovie(id: 1)]));
        await container.read(popularMoviesProvider.notifier).retry();

        // then
        final state = container.read(popularMoviesProvider);
        expect(state.movies.length, 1);
        expect(state.hasError, isFalse);
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
      genreIds: const [28],
      adult: false,
      video: false,
      originalLanguage: 'en',
    );
