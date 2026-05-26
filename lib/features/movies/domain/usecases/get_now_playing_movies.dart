import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';

class GetNowPlayingMovies {
  const GetNowPlayingMovies(this._repository);

  final MovieRepository _repository;

  Result<List<Movie>> call({int page = 1}) =>
      _repository.getNowPlaying(page: page);
}
