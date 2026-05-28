import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

extension MovieModelMapper on MovieModel {
  Movie toEntity({
    required String imageBaseUrl,
    required String noImageUrl,
  }) => Movie(
    id: id,
    title: title,
    originalTitle: originalTitle,
    overview: overview,
    posterPath: posterPath.isNotEmpty
        ? '$imageBaseUrl$posterPath'
        : noImageUrl,
    backdropPath: backdropPath.isNotEmpty
        ? '$imageBaseUrl$backdropPath'
        : noImageUrl,
    releaseDate: releaseDate,
    popularity: popularity,
    voteAverage: voteAverage,
    voteCount: voteCount,
    genreIds: genreIds,
    adult: adult,
    video: video,
    originalLanguage: originalLanguage,
  );
}
