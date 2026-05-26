import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_state.dart';

void main() {
  group('MovieListState.showInitialLoader', () {
    test('given isLoading is true and movies list is empty '
        'when showInitialLoader is checked '
        'then returns true', () {
      const state = MovieListState(isLoading: true);
      expect(state.showInitialLoader, isTrue);
    });

    test('given isLoading is true but movies are already loaded '
        'when showInitialLoader is checked '
        'then returns false', () {
      final state = MovieListState(isLoading: true, movies: [_tMovie()]);
      expect(state.showInitialLoader, isFalse);
    });
  });

  group('MovieListState.showInitialError', () {
    test('given hasError is true and movies list is empty '
        'when showInitialError is checked '
        'then returns true', () {
      const state = MovieListState(hasError: true);
      expect(state.showInitialError, isTrue);
    });

    test('given hasError is true but movies are already loaded '
        'when showInitialError is checked '
        'then returns false', () {
      final state = MovieListState(hasError: true, movies: [_tMovie()]);
      expect(state.showInitialError, isFalse);
    });
  });

  group('MovieListState.copyWith', () {
    test('given an existing state '
        'when copyWith is called with new movies '
        'then only movies are updated and error is reset', () {
      // given
      const original = MovieListState(isLoading: true, hasError: false);

      // when
      final updated = original.copyWith(movies: [_tMovie()], isLoading: false);

      // then
      expect(updated.movies.length, 1);
      expect(updated.isLoading, isFalse);
      expect(updated.hasError, isFalse);
    });

    test('given a state with movies '
        'when copyWith is called without arguments '
        'then movies are preserved and hasError resets to false', () {
      // given
      final original = MovieListState(movies: [_tMovie()]);

      // when
      final updated = original.copyWith();

      // then
      expect(updated.movies.length, 1);
      expect(updated.hasError, isFalse);
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
  genreIds: [28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
