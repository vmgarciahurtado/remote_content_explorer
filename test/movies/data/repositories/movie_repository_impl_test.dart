import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/error_handler/failures.dart';
import 'package:remote_content_explorer/core/network/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
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

  const String tImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  const String tActorImageBaseUrl = 'https://image.tmdb.org/t/p/w185';

  setUp(() {
    mockDatasource = MockMovieRemoteDatasource();
    repository = MovieRepositoryImpl(
      mockDatasource,
      imageBaseUrl: tImageBaseUrl,
      actorImageBaseUrl: tActorImageBaseUrl,
    );
  });

  group('MovieRepositoryImpl', () {
    test('given the datasource returns a movie response '
        'when getNowPlaying is called '
        'then returns the mapped movies with no failure', () async {
      // given
      when(
        () => mockDatasource.getNowPlaying(page: any(named: 'page')),
      ).thenAnswer((_) async => _tMovieResponse());

      // when
      final Result<List<Movie>> result = await repository.getNowPlaying();

      // then
      expect(result, isA<Success<List<Movie>>>());
      final List<Movie> movies = (result as Success<List<Movie>>).data;
      expect(movies.length, 1);
      expect(movies.first.id, 1);
      expect(
        movies.first.posterPath,
        'https://image.tmdb.org/t/p/w500/poster.jpg',
      );
    });

    test('given the datasource throws a DioException '
        'when getNowPlaying is called '
        'then returns the appropriate failure', () async {
      // given
      when(
        () => mockDatasource.getNowPlaying(page: any(named: 'page')),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
          response: Response<dynamic>(
            requestOptions: RequestOptions(),
            statusCode: 401,
          ),
        ),
      );

      // when
      final Result<List<Movie>> result = await repository.getNowPlaying();

      // then
      expect(result, isA<FailureResult<List<Movie>>>());
      final Failure failure = (result as FailureResult<List<Movie>>).failure;
      expect(failure, isA<UnauthorizedFailure>());
    });

    test('given the datasource returns a movie response '
        'when getPopular is called '
        'then returns the mapped movies with no failure', () async {
      // given
      when(
        () => mockDatasource.getPopular(page: any(named: 'page')),
      ).thenAnswer((_) async => _tMovieResponse());

      // when
      final Result<List<Movie>> result = await repository.getPopular();

      // then
      expect(result, isA<Success<List<Movie>>>());
      final List<Movie> movies = (result as Success<List<Movie>>).data;
      expect(movies.first.id, 1);
    });

    test('given the datasource returns a movie response '
        'when searchMovies is called '
        'then returns the mapped movies with no failure', () async {
      // given
      when(
        () => mockDatasource.searchMovies(query: any(named: 'query')),
      ).thenAnswer((_) async => _tMovieResponse());

      // when
      final Result<List<Movie>> result = await repository.searchMovies(
        'batman',
      );

      // then
      expect(result, isA<Success<List<Movie>>>());
      final List<Movie> movies = (result as Success<List<Movie>>).data;
      expect(movies.first.title, 'Test Movie');
    });

    test('given the datasource returns a cast response '
        'when getMovieCast is called '
        'then returns the mapped actors with no failure', () async {
      // given
      when(
        () => mockDatasource.getMovieCast(any()),
      ).thenAnswer((_) async => _tCastResponse());

      // when
      final Result<List<Actor>> result = await repository.getMovieCast(1);

      // then
      expect(result, isA<Success<List<Actor>>>());
      final List<Actor> actors = (result as Success<List<Actor>>).data;
      expect(actors.length, 1);
      expect(actors.first.name, 'John Doe');
      expect(
        actors.first.profilePath,
        'https://image.tmdb.org/t/p/w185/profile.jpg',
      );
    });
  });
}

MovieResponse _tMovieResponse() => const MovieResponse(
  page: 1,
  totalPages: 1,
  totalResults: 1,
  results: <MovieModel>[
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
      genreIds: <int>[28],
      adult: false,
      video: false,
      originalLanguage: 'en',
    ),
  ],
);

CastResponse _tCastResponse() => const CastResponse(
  id: 1,
  cast: <ActorModel>[
    ActorModel(
      id: 10,
      name: 'John Doe',
      character: 'Hero',
      profilePath: '/profile.jpg',
    ),
  ],
);
