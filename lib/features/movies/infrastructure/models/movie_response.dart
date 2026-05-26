import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

class MovieResponse {
  const MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    page: (json['page'] as num).toInt(),
    results: (json['results'] as List<dynamic>)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalPages: (json['total_pages'] as num).toInt(),
    totalResults: (json['total_results'] as num).toInt(),
  );
}
