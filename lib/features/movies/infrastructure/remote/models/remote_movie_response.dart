import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';

class RemoteMovieResponse {
  const RemoteMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<RemoteMovieModel> results;
  final int totalPages;
  final int totalResults;
}
