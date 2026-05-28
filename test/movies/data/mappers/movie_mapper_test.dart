import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

void main() {
  group('MovieModelMapper', () {
    const String tImageBaseUrl = 'https://image.tmdb.org/t/p/w500';

    test('given a model with a non-empty poster path '
        'when toEntity is called '
        'then the poster URL is prefixed with the image base URL', () {
      // given
      final MovieModel model = _tMovieModel();

      // when
      final Movie entity = model.toEntity(imageBaseUrl: tImageBaseUrl);

      // then
      expect(entity.posterPath, 'https://image.tmdb.org/t/p/w500/poster.jpg');
    });

    test('given a model with an empty poster path '
        'when toEntity is called '
        'then the fallback image URL is used', () {
      // given
      final MovieModel model = _tMovieModel(posterPath: '');

      // when
      final Movie entity = model.toEntity(imageBaseUrl: tImageBaseUrl);

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
      final MovieModel model = _tMovieModel(backdropPath: '');

      // when
      final Movie entity = model.toEntity(imageBaseUrl: tImageBaseUrl);

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
  genreIds: const <int>[28],
  adult: false,
  video: false,
  originalLanguage: 'en',
);
