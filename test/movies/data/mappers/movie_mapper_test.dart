import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

void main() {
  group('MovieModelMapper', () {
    test('given a model with a non-empty poster path '
        'when toEntity is called '
        'then the poster URL is prefixed with the image base URL', () {
      // given
      final model = _tMovieModel(posterPath: '/poster.jpg');

      // when
      final entity = model.toEntity();

      // then
      expect(entity.posterPath, 'https://image.tmdb.org/t/p/w500/poster.jpg');
    });

    test('given a model with an empty poster path '
        'when toEntity is called '
        'then the fallback image URL is used', () {
      // given
      final model = _tMovieModel(posterPath: '');

      // when
      final entity = model.toEntity();

      // then
      expect(
        entity.posterPath,
        'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      );
    });

    test('given a model with an empty backdrop path '
        'when toEntity is called '
        'then the fallback image URL is used for the backdrop', () {
      // given
      final model = _tMovieModel(backdropPath: '');

      // when
      final entity = model.toEntity();

      // then
      expect(
        entity.backdropPath,
        'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      );
    });
  });
}

MovieModel _tMovieModel({
  String posterPath = '/poster.jpg',
  String backdropPath = '/backdrop.jpg',
}) => MovieModel(
  id: 1,
  title: 'Test Movie',
  originalTitle: 'Test Movie',
  overview: 'Overview',
  posterPath: posterPath,
  backdropPath: backdropPath,
  releaseDate: '2024-01-01',
  popularity: 100.0,
  voteAverage: 7.5,
  voteCount: 1000,
  genreIds: const [28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
