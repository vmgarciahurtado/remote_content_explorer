import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';

abstract interface class MovieRepository {
  Result<List<Movie>> getNowPlaying({int page = 1});
  Result<List<Movie>> getPopular({int page = 1});
  Result<List<Movie>> searchMovies(String query);
  Result<List<Actor>> getMovieCast(int movieId);
}
