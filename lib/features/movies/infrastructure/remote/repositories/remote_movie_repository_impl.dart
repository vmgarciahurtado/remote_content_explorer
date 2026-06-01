import 'package:remote_content_explorer/core/helpers/execute_repository_call.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';
import 'package:remote_content_explorer/core/services/http/http_method.dart';
import 'package:remote_content_explorer/core/services/http/http_service.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/mappers/remote_actor_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/mappers/remote_movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_cast_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_response.dart';

class RemoteMovieRepositoryImpl implements MovieRepository {
  RemoteMovieRepositoryImpl(
    this._httpService, {
    required String imageBaseUrl,
    required String noImageUrl,
    required String actorImageBaseUrl,
  }) : _imageBaseUrl = imageBaseUrl,
       _noImageUrl = noImageUrl,
       _actorImageBaseUrl = actorImageBaseUrl;

  final HttpService _httpService;
  final String _imageBaseUrl;
  final String _noImageUrl;
  final String _actorImageBaseUrl;

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService.request(
          'movie/now_playing',
          method: HttpMethod.get,
          queryParameters: <String, dynamic>{'page': page},
        );
        final RemoteMovieResponse data =
            RemoteMovieMapper.movieResponseFromJson(response);
        return data.results
            .map(
              (RemoteMovieModel m) => RemoteMovieMapper.toEntity(
                m,
                imageBaseUrl: _imageBaseUrl,
                noImageUrl: _noImageUrl,
              ),
            )
            .toList();
      });

  @override
  Future<Result<List<Movie>>> getPopular({int page = 1}) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService.request(
          'movie/popular',
          method: HttpMethod.get,
          queryParameters: <String, dynamic>{'page': page},
        );
        final RemoteMovieResponse data =
            RemoteMovieMapper.movieResponseFromJson(response);
        return data.results
            .map(
              (RemoteMovieModel m) => RemoteMovieMapper.toEntity(
                m,
                imageBaseUrl: _imageBaseUrl,
                noImageUrl: _noImageUrl,
              ),
            )
            .toList();
      });

  @override
  Future<Result<List<Actor>>> getMovieCast(int movieId) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService.request(
          'movie/$movieId/credits',
          method: HttpMethod.get,
        );
        final RemoteCastResponse data = RemoteActorMapper.castResponseFromJson(
          response,
        );
        return data.cast
            .map(
              (RemoteActorModel a) => RemoteActorMapper.toEntity(
                a,
                actorImageBaseUrl: _actorImageBaseUrl,
              ),
            )
            .toList();
      });

  @override
  Future<Result<List<Movie>>> searchMovies(String query) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService.request(
          'search/movie',
          method: HttpMethod.get,
          queryParameters: <String, dynamic>{'query': query},
        );
        final RemoteMovieResponse data =
            RemoteMovieMapper.movieResponseFromJson(response);
        return data.results
            .map(
              (RemoteMovieModel m) => RemoteMovieMapper.toEntity(
                m,
                imageBaseUrl: _imageBaseUrl,
                noImageUrl: _noImageUrl,
              ),
            )
            .toList();
      });
}
