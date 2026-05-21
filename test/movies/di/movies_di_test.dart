import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/movies/di/movies_di.dart';
import 'package:remote_content_explorer/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/movies/domain/usecases/search_movies.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() => container.dispose());

  group('movies DI providers', () {
    test(
      'given the provider graph '
      'when movieRepositoryProvider is read '
      'then returns a MovieRepository instance',
      () {
        expect(container.read(movieRepositoryProvider), isA<MovieRepository>());
      },
    );

    test(
      'given the provider graph '
      'when getNowPlayingMoviesProvider is read '
      'then returns a GetNowPlayingMovies use case',
      () {
        expect(
          container.read(getNowPlayingMoviesProvider),
          isA<GetNowPlayingMovies>(),
        );
      },
    );

    test(
      'given the provider graph '
      'when getPopularMoviesProvider is read '
      'then returns a GetPopularMovies use case',
      () {
        expect(
          container.read(getPopularMoviesProvider),
          isA<GetPopularMovies>(),
        );
      },
    );

    test(
      'given the provider graph '
      'when getMovieCastProvider is read '
      'then returns a GetMovieCast use case',
      () {
        expect(container.read(getMovieCastProvider), isA<GetMovieCast>());
      },
    );

    test(
      'given the provider graph '
      'when searchMoviesProvider is read '
      'then returns a SearchMovies use case',
      () {
        expect(container.read(searchMoviesProvider), isA<SearchMovies>());
      },
    );
  });
}
