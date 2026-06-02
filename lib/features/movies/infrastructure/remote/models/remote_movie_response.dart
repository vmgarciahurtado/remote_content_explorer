import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';

class RemoteMovieResponse {
  const RemoteMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory RemoteMovieResponse.fromJson(Map<String, dynamic> json) =>
      RemoteMovieResponse(
        page: (json['page'] as num).toInt(),
        results: (json['results'] as List<dynamic>)
            .map(
              (dynamic e) =>
                  RemoteMovieModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        totalPages: (json['total_pages'] as num).toInt(),
        totalResults: (json['total_results'] as num).toInt(),
      );

  final int page;
  final List<RemoteMovieModel> results;
  final int totalPages;
  final int totalResults;
}
