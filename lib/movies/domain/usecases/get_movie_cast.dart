import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/movies/domain/repositories/movie_repository.dart';

class GetMovieCast {
  const GetMovieCast(this._repository);

  final MovieRepository _repository;

  Result<List<Actor>> call(int movieId) =>
      _repository.getMovieCast(movieId);
}
