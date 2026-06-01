import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/mappers/remote_movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';

void main() {
  group('RemoteMovieMapper.toEntity', () {
    const String tImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    const String tNoImageUrl = 'https://image.tmdb.org/t/p/w500/fallback.jpg';

    test(
      'given a model with a non-empty poster path when toEntity is called '
      'then the poster URL is prefixed with the image base URL',
      () {
        final RemoteMovieModel model = _tMovieModel();

        final Movie entity = RemoteMovieMapper.toEntity(
          model,
          imageBaseUrl: tImageBaseUrl,
          noImageUrl: tNoImageUrl,
        );

        expect(entity.posterPath, 'https://image.tmdb.org/t/p/w500/poster.jpg');
      },
    );

    test(
      'given a model with an empty poster path when toEntity is called '
      'then the fallback image URL is used',
      () {
        final RemoteMovieModel model = _tMovieModel(posterPath: '');

        final Movie entity = RemoteMovieMapper.toEntity(
          model,
          imageBaseUrl: tImageBaseUrl,
          noImageUrl: tNoImageUrl,
        );

        expect(entity.posterPath, tNoImageUrl);
      },
    );

    test(
      'given a model with an empty backdrop path when toEntity is called '
      'then the fallback image URL is used for the backdrop',
      () {
        final RemoteMovieModel model = _tMovieModel(backdropPath: '');

        final Movie entity = RemoteMovieMapper.toEntity(
          model,
          imageBaseUrl: tImageBaseUrl,
          noImageUrl: tNoImageUrl,
        );

        expect(entity.backdropPath, tNoImageUrl);
      },
    );
  });
}

RemoteMovieModel _tMovieModel({
  String posterPath = '/poster.jpg',
  String backdropPath = '/backdrop.jpg',
}) =>
    RemoteMovieModel(
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
