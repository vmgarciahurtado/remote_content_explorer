import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/failure.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/datasources/movie_remote_datasource.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/cast_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';

class MockMovieRemoteDatasource extends Mock implements MovieRemoteDatasource {}

void main() {
  late MockMovieRemoteDatasource mockDatasource;
  late MovieRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockMovieRemoteDatasource();
    repository = MovieRepositoryImpl(mockDatasource);
  });

  group('MovieRepositoryImpl', () {
    test('given the datasource returns a movie response '
        'when getNowPlaying is called '
        'then returns Right with the mapped movies', () async {
      // given
      when(
        () => mockDatasource.getNowPlaying(page: any(named: 'page')),
      ).thenAnswer((_) async => _tMovieResponse());

      // when
      final result = await repository.getNowPlaying();

      // then
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('Expected Right'), (movies) {
        expect(movies.length, 1);
        expect(movies.first.id, 1);
        expect(
          movies.first.posterPath,
          'https://image.tmdb.org/t/p/w500/poster.jpg',
        );
      });
    });

    test('given the datasource throws a DioException '
        'when getNowPlaying is called '
        'then returns Left with the appropriate failure', () async {
      // given
      when(
        () => mockDatasource.getNowPlaying(page: any(named: 'page')),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 401,
          ),
        ),
      );

      // when
      final result = await repository.getNowPlaying();

      // then
      expect(result.isLeft(), isTrue);
      result.fold(
        (f) => expect(f, isA<UnauthorizedFailure>()),
        (_) => fail(''),
      );
    });

    test('given the datasource returns a movie response '
        'when getPopular is called '
        'then returns Right with the mapped movies', () async {
      // given
      when(
        () => mockDatasource.getPopular(page: any(named: 'page')),
      ).thenAnswer((_) async => _tMovieResponse());

      // when
      final result = await repository.getPopular();

      // then
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (movies) => expect(movies.first.id, 1),
      );
    });

    test('given the datasource returns a movie response '
        'when searchMovies is called '
        'then returns Right with the mapped movies', () async {
      // given
      when(
        () => mockDatasource.searchMovies(query: any(named: 'query')),
      ).thenAnswer((_) async => _tMovieResponse());

      // when
      final result = await repository.searchMovies('batman');

      // then
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (movies) => expect(movies.first.title, 'Test Movie'),
      );
    });

    test('given the datasource returns a cast response '
        'when getMovieCast is called '
        'then returns Right with the mapped actors', () async {
      // given
      when(
        () => mockDatasource.getMovieCast(any()),
      ).thenAnswer((_) async => _tCastResponse());

      // when
      final result = await repository.getMovieCast(1);

      // then
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('Expected Right'), (actors) {
        expect(actors.length, 1);
        expect(actors.first.name, 'John Doe');
        expect(
          actors.first.profilePath,
          'https://image.tmdb.org/t/p/w185/profile.jpg',
        );
      });
    });
  });
}

MovieResponse _tMovieResponse() => const MovieResponse(
  page: 1,
  totalPages: 1,
  totalResults: 1,
  results: [
    MovieModel(
      id: 1,
      title: 'Test Movie',
      originalTitle: 'Test Movie',
      overview: 'Overview',
      posterPath: '/poster.jpg',
      backdropPath: '/backdrop.jpg',
      releaseDate: '2024-01-01',
      popularity: 100.0,
      voteAverage: 7.5,
      voteCount: 1000,
      genreIds: [28],
      adult: false,
      video: false,
      originalLanguage: 'en',
    ),
  ],
);

CastResponse _tCastResponse() => const CastResponse(
  id: 1,
  cast: [
    ActorModel(
      id: 10,
      name: 'John Doe',
      character: 'Hero',
      profilePath: '/profile.jpg',
    ),
  ],
);
