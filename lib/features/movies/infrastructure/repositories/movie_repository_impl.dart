import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/datasources/movie_remote_datasource.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/actor_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(this._datasource);

  final MovieRemoteDatasource _datasource;

  @override
  Result<List<Movie>> getNowPlaying({int page = 1}) => executeApiCall(
    () async => (await _datasource.getNowPlaying(
      page: page,
    )).results.map((MovieModel m) => m.toEntity()).toList(),
  );

  @override
  Result<List<Movie>> getPopular({int page = 1}) => executeApiCall(
    () async => (await _datasource.getPopular(
      page: page,
    )).results.map((MovieModel m) => m.toEntity()).toList(),
  );

  @override
  Result<List<Movie>> searchMovies(String query) => executeApiCall(
    () async => (await _datasource.searchMovies(
      query: query,
    )).results.map((MovieModel m) => m.toEntity()).toList(),
  );

  @override
  Result<List<Actor>> getMovieCast(int movieId) => executeApiCall(
    () async => (await _datasource.getMovieCast(
      movieId,
    )).cast.map((ActorModel a) => a.toEntity()).toList(),
  );
}

final Provider<MovieRepository> movieRepositoryProvider =
    Provider<MovieRepository>(
      (Ref ref) => MovieRepositoryImpl(
        ref.watch(movieRemoteDatasourceProvider),
      ),
    );
