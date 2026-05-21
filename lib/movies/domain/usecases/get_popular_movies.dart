import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/movies/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  const GetPopularMovies(this._repository);

  final MovieRepository _repository;

  Result<List<Movie>> call({int page = 1}) =>
      _repository.getPopular(page: page);
}
