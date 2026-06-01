import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_response.dart';

class RemoteMovieMapper {
  static RemoteMovieModel movieModelFromJson(Map<String, dynamic> json) =>
      RemoteMovieModel(
        id: (json['id'] as num).toInt(),
        title: json['title'] as String,
        originalTitle: json['original_title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String? ?? '',
        backdropPath: json['backdrop_path'] as String? ?? '',
        releaseDate: json['release_date'] as String? ?? '',
        popularity: (json['popularity'] as num).toDouble(),
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: (json['vote_count'] as num).toInt(),
        genreIds: (json['genre_ids'] as List<dynamic>?)
                ?.map((dynamic e) => (e as num).toInt())
                .toList() ??
            <int>[],
        adult: json['adult'] as bool? ?? false,
        video: json['video'] as bool? ?? false,
        originalLanguage: json['original_language'] as String? ?? '',
      );

  static RemoteMovieResponse movieResponseFromJson(Map<String, dynamic> json) =>
      RemoteMovieResponse(
        page: (json['page'] as num).toInt(),
        results: (json['results'] as List<dynamic>)
            .map((dynamic e) => movieModelFromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: (json['total_pages'] as num).toInt(),
        totalResults: (json['total_results'] as num).toInt(),
      );

  static Movie toEntity(
    RemoteMovieModel model, {
    required String imageBaseUrl,
    required String noImageUrl,
  }) =>
      Movie(
        id: model.id,
        title: model.title,
        originalTitle: model.originalTitle,
        overview: model.overview,
        posterPath: model.posterPath.isNotEmpty
            ? '$imageBaseUrl${model.posterPath}'
            : noImageUrl,
        backdropPath: model.backdropPath.isNotEmpty
            ? '$imageBaseUrl${model.backdropPath}'
            : noImageUrl,
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
