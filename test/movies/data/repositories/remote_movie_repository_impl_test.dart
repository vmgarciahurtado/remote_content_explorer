import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/errors/failures.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';
import 'package:remote_content_explorer/core/services/http/http_method.dart';
import 'package:remote_content_explorer/core/services/http/http_service.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/repositories/remote_movie_repository_impl.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  late MockHttpService mockHttpService;
  late RemoteMovieRepositoryImpl repository;

  const String tImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  const String tNoImageUrl = 'https://img.com/fallback.jpg';
  const String tActorImageBaseUrl = 'https://image.tmdb.org/t/p/w185';

  setUp(() {
    mockHttpService = MockHttpService();
    repository = RemoteMovieRepositoryImpl(
      mockHttpService,
      imageBaseUrl: tImageBaseUrl,
      noImageUrl: tNoImageUrl,
      actorImageBaseUrl: tActorImageBaseUrl,
    );
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
  });

  group('RemoteMovieRepositoryImpl.getNowPlaying', () {
    test(
      'given a successful http request when getNowPlaying is called '
      'then returns success with movies',
      () async {
        when(
          () => mockHttpService.request<Map<String, dynamic>>(
            any(),
            method: any(named: 'method'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => _tMovieResponseJson());

        final Result<List<Movie>> result = await repository.getNowPlaying();

        expect(result, isA<Success<List<Movie>>>());
        final List<Movie> movies = (result as Success<List<Movie>>).data;
        expect(movies.length, 1);
        expect(movies.first.id, 1);
        expect(
          movies.first.posterPath,
          'https://image.tmdb.org/t/p/w500/poster.jpg',
        );
      },
    );

    test(
      'given http service throws ConnectionFailure when getNowPlaying is '
      'called then returns ConnectionFailure Result',
      () async {
        when(
          () => mockHttpService.request<Map<String, dynamic>>(
            any(),
            method: any(named: 'method'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(const ConnectionFailure());

        final Result<List<Movie>> result = await repository.getNowPlaying();

        expect(result, isA<FailureResult<List<Movie>>>());
        final Failure failure = (result as FailureResult<List<Movie>>).failure;
        expect(failure, isA<ConnectionFailure>());
      },
    );
  });

  group('RemoteMovieRepositoryImpl.getPopular', () {
    test(
      'given a successful http request when getPopular is called '
      'then returns success with movies',
      () async {
        when(
          () => mockHttpService.request<Map<String, dynamic>>(
            any(),
            method: any(named: 'method'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => _tMovieResponseJson());

        final Result<List<Movie>> result = await repository.getPopular();

        expect(result, isA<Success<List<Movie>>>());
        final List<Movie> movies = (result as Success<List<Movie>>).data;
        expect(movies.first.id, 1);
      },
    );
  });

  group('RemoteMovieRepositoryImpl.searchMovies', () {
    test(
      'given a successful http request when searchMovies is called '
      'then returns success with movies',
      () async {
        when(
          () => mockHttpService.request<Map<String, dynamic>>(
            any(),
            method: any(named: 'method'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => _tMovieResponseJson());

        final Result<List<Movie>> result = await repository.searchMovies(
          'batman',
        );

        expect(result, isA<Success<List<Movie>>>());
        final List<Movie> movies = (result as Success<List<Movie>>).data;
        expect(movies.first.title, 'Batman');
      },
    );
  });

  group('RemoteMovieRepositoryImpl.getMovieCast', () {
    test(
      'given a successful http request when getMovieCast is called '
      'then returns success with cast list',
      () async {
        when(
          () => mockHttpService.request<Map<String, dynamic>>(
            any(),
            method: any(named: 'method'),
          ),
        ).thenAnswer((_) async => _tCastResponseJson());

        final Result<List<Actor>> result = await repository.getMovieCast(1);

        expect(result, isA<Success<List<Actor>>>());
        final List<Actor> actors = (result as Success<List<Actor>>).data;
        expect(actors.length, 1);
        expect(actors.first.name, 'Christian Bale');
        expect(
          actors.first.profilePath,
          'https://image.tmdb.org/t/p/w185/bale.jpg',
        );
      },
    );
  });
}

Map<String, dynamic> _tMovieResponseJson() => <String, dynamic>{
  'page': 1,
  'total_pages': 10,
  'total_results': 200,
  'results': <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 1,
      'title': 'Batman',
      'original_title': 'Batman',
      'overview': 'Gotham hero',
      'poster_path': '/poster.jpg',
      'backdrop_path': '/backdrop.jpg',
      'release_date': '2022-03-04',
      'popularity': 98.5,
      'vote_average': 7.3,
      'vote_count': 5432,
      'genre_ids': <int>[28, 12],
      'adult': false,
      'video': false,
      'original_language': 'en',
    },
  ],
};

Map<String, dynamic> _tCastResponseJson() => <String, dynamic>{
  'id': 1,
  'cast': <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 10,
      'name': 'Christian Bale',
      'character': 'Bruce Wayne',
      'profile_path': '/bale.jpg',
    },
  ],
};
