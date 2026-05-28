import 'package:remote_content_explorer/core/network/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getNowPlaying({int page = 1});
  Future<Result<List<Movie>>> getPopular({int page = 1});
  Future<Result<List<Movie>>> searchMovies(String query);
  Future<Result<List<Actor>>> getMovieCast(int movieId);
}
