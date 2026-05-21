import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/movies/domain/repositories/movie_repository.dart';

class SearchMovies {
  const SearchMovies(this._repository);

  final MovieRepository _repository;

  Result<List<Movie>> call(String query) =>
      _repository.searchMovies(query);
}
