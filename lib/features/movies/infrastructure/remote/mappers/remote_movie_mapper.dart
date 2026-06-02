import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/services/image_url_resolver.dart';

class RemoteMovieMapper {
  const RemoteMovieMapper._();

  static Movie toEntity(RemoteMovieModel model, ImageUrlResolver resolver) =>
      Movie(
        id: model.id,
        title: model.title,
        originalTitle: model.originalTitle,
        overview: model.overview,
        posterPath: resolver.movieImage(model.posterPath),
        backdropPath: resolver.movieImage(model.backdropPath),
        releaseDate: model.releaseDate,
        popularity: model.popularity,
        voteAverage: model.voteAverage,
        voteCount: model.voteCount,
        genreIds: model.genreIds,
        adult: model.adult,
        video: model.video,
        originalLanguage: model.originalLanguage,
      );
}
