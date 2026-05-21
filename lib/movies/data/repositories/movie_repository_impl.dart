import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/movies/data/datasources/movie_remote_datasource.dart';
import 'package:remote_content_explorer/movies/data/mappers/actor_mapper.dart';
import 'package:remote_content_explorer/movies/data/mappers/movie_mapper.dart';
import 'package:remote_content_explorer/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(this._datasource);

  final MovieRemoteDatasource _datasource;

  @override
  Result<List<Movie>> getNowPlaying({int page = 1}) => executeApiCall(
    () async => (await _datasource.getNowPlaying(page: page))
        .results
        .map((m) => m.toEntity())
        .toList(),
  );

  @override
  Result<List<Movie>> getPopular({int page = 1}) => executeApiCall(
    () async => (await _datasource.getPopular(page: page))
        .results
        .map((m) => m.toEntity())
        .toList(),
  );

  @override
  Result<List<Movie>> searchMovies(String query) => executeApiCall(
    () async => (await _datasource.searchMovies(query: query))
        .results
        .map((m) => m.toEntity())
        .toList(),
  );

  @override
  Result<List<Actor>> getMovieCast(int movieId) => executeApiCall(
    () async => (await _datasource.getMovieCast(movieId))
        .cast
        .map((a) => a.toEntity())
        .toList(),
  );
}
