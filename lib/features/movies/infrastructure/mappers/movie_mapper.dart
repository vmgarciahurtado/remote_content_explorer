import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';

const _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
const _noImageUrl =
    'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg';

extension MovieModelMapper on MovieModel {
  Movie toEntity() => Movie(
    id: id,
    title: title,
    originalTitle: originalTitle,
    overview: overview,
    posterPath: posterPath.isNotEmpty ? '$_imageBaseUrl$posterPath' : _noImageUrl,
    backdropPath:
        backdropPath.isNotEmpty ? '$_imageBaseUrl$backdropPath' : _noImageUrl,
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
