import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/movies/domain/usecases/search_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    registerFallbackValue(<Movie>[]);
    registerFallbackValue(<Actor>[]);
  });

  group('GetNowPlayingMovies', () {
    test(
      'given a repository with movies '
      'when called '
      'then delegates to repository.getNowPlaying with the given page',
      () async {
        // given
        when(() => mockRepository.getNowPlaying(page: any(named: 'page')))
            .thenAnswer((_) async => Right([_tMovie()]));
        final useCase = GetNowPlayingMovies(mockRepository);

        // when
        final result = await useCase.call(page: 2);

        // then
        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getNowPlaying(page: 2)).called(1);
      },
    );
  });

  group('GetPopularMovies', () {
    test(
      'given a repository with movies '
      'when called '
      'then delegates to repository.getPopular with the given page',
      () async {
        // given
        when(() => mockRepository.getPopular(page: any(named: 'page')))
            .thenAnswer((_) async => Right([_tMovie()]));
        final useCase = GetPopularMovies(mockRepository);

        // when
        final result = await useCase.call(page: 3);

        // then
        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getPopular(page: 3)).called(1);
      },
    );
  });

  group('SearchMovies', () {
    test(
      'given a repository that returns results '
      'when called with a query '
      'then delegates to repository.searchMovies with the same query',
      () async {
        // given
        when(() => mockRepository.searchMovies(any()))
            .thenAnswer((_) async => Right([_tMovie()]));
        final useCase = SearchMovies(mockRepository);

        // when
        final result = await useCase.call('batman');

        // then
        expect(result.isRight(), isTrue);
        verify(() => mockRepository.searchMovies('batman')).called(1);
      },
    );
  });

  group('GetMovieCast', () {
    test(
      'given a repository that returns a cast '
      'when called with a movie id '
      'then delegates to repository.getMovieCast with the same id',
      () async {
        // given
        when(() => mockRepository.getMovieCast(any()))
            .thenAnswer((_) async => Right([_tActor()]));
        final useCase = GetMovieCast(mockRepository);

        // when
        final result = await useCase.call(42);

        // then
        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getMovieCast(42)).called(1);
      },
    );
  });
}

Movie _tMovie() => const Movie(
      id: 1,
      title: 'Test Movie',
      originalTitle: 'Test Movie',
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

Actor _tActor() => const Actor(
      id: 1,
      name: 'John Doe',
      character: 'Hero',
      profilePath: null,
    );
