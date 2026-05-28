import 'package:remote_content_explorer/core/network/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';

class GetMovieCast {
  const GetMovieCast(this._repository);

  final MovieRepository _repository;

  Future<Result<List<Actor>>> call(int movieId) =>
      _repository.getMovieCast(movieId);
}
