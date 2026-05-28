import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_provider.dart';

void main() {
  group('MovieListState.copyWith', () {
    test('given a state with isLoading and hasError '
        'when copyWith updates only movies '
        'then all other fields are preserved', () {
      // given
      const MovieListState original = MovieListState(
        isLoading: true,
        hasError: true,
      );

      // when
      final MovieListState updated = original.copyWith(
        movies: <Movie>[_tMovie()],
      );

      // then
      expect(updated.movies.length, 1);
      expect(updated.isLoading, isTrue);
      expect(updated.hasError, isTrue);
    });

    test('given a state with movies and hasError '
        'when copyWith is called with no arguments '
        'then all fields are preserved', () {
      // given
      final MovieListState original = MovieListState(
        movies: <Movie>[_tMovie()],
        hasError: true,
      );

      // when
      final MovieListState updated = original.copyWith();

      // then
      expect(updated.movies.length, 1);
      expect(updated.hasError, isTrue);
    });
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
  genreIds: <int>[28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
