import 'package:json_annotation/json_annotation.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

part 'movie_response.g.dart';

@JsonSerializable(createToJson: false)
class MovieResponse {
  const MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieModel> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
