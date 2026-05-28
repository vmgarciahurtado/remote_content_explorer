import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/constants/config_providers.dart';
import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/core/network/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/datasources/movie_remote_datasource.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/actor_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/mappers/movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(
    this._datasource, {
    required String imageBaseUrl,
    required String actorImageBaseUrl,
    required String noImageUrl,
  }) : _imageBaseUrl = imageBaseUrl,
       _actorImageBaseUrl = actorImageBaseUrl,
       _noImageUrl = noImageUrl;

  final MovieRemoteDatasource _datasource;
  final String _imageBaseUrl;
  final String _actorImageBaseUrl;
  final String _noImageUrl;

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) => executeApiCall(
    () async =>
        (await _datasource.getNowPlaying(
              page: page,
            )).results
            .map((MovieModel m) => m.toEntity(
                  imageBaseUrl: _imageBaseUrl,
                  noImageUrl: _noImageUrl,
                ))
            .toList(),
  );

  @override
  Future<Result<List<Movie>>> getPopular({int page = 1}) => executeApiCall(
    () async =>
        (await _datasource.getPopular(
              page: page,
            )).results
            .map((MovieModel m) => m.toEntity(
                  imageBaseUrl: _imageBaseUrl,
                  noImageUrl: _noImageUrl,
                ))
            .toList(),
  );

  @override
  Future<Result<List<Movie>>> searchMovies(String query) => executeApiCall(
    () async =>
        (await _datasource.searchMovies(
              query: query,
            )).results
            .map((MovieModel m) => m.toEntity(
                  imageBaseUrl: _imageBaseUrl,
                  noImageUrl: _noImageUrl,
                ))
            .toList(),
  );

  @override
  Future<Result<List<Actor>>> getMovieCast(int movieId) => executeApiCall(
    () async =>
        (await _datasource.getMovieCast(
              movieId,
            )).cast
            .map(
              (ActorModel a) =>
                  a.toEntity(actorImageBaseUrl: _actorImageBaseUrl),
            )
            .toList(),
  );
}

final Provider<MovieRepository> movieRepositoryProvider =
    Provider<MovieRepository>(
      (Ref ref) => MovieRepositoryImpl(
        ref.watch(movieRemoteDatasourceProvider),
        imageBaseUrl: ref.watch(imageBaseUrlProvider),
        actorImageBaseUrl: ref.watch(actorImageBaseUrlProvider),
        noImageUrl: ref.watch(noImageUrlProvider),
      ),
    );
