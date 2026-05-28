import 'package:remote_content_explorer/core/constants/env.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

extension MovieModelMapper on MovieModel {
  Movie toEntity() => Movie(
    id: id,
    title: title,
    originalTitle: originalTitle,
    overview: overview,
    posterPath: posterPath.isNotEmpty
        ? '${Env.imageBaseUrl}$posterPath'
        : Env.noImageUrl,
    backdropPath: backdropPath.isNotEmpty
        ? '${Env.imageBaseUrl}$backdropPath'
        : Env.noImageUrl,
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
