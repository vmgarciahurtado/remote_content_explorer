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
import 'package:remote_content_explorer/features/movies/infrastructure/remote/services/image_url_resolver.dart';

class RemoteMovieRepositoryImpl implements MovieRepository {
  RemoteMovieRepositoryImpl(this._httpService, this._imageUrlResolver);

  final HttpService _httpService;
  final ImageUrlResolver _imageUrlResolver;

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService
            .request<Map<String, dynamic>>(
              'movie/now_playing',
              method: HttpMethod.get,
              queryParameters: <String, dynamic>{'page': page},
            );
        final RemoteMovieResponse data = RemoteMovieResponse.fromJson(response);
        return data.results
            .map(
              (RemoteMovieModel m) =>
                  RemoteMovieMapper.toEntity(m, _imageUrlResolver),
            )
            .toList();
      });

  @override
  Future<Result<List<Movie>>> getPopular({int page = 1}) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService
            .request<Map<String, dynamic>>(
              'movie/popular',
              method: HttpMethod.get,
              queryParameters: <String, dynamic>{'page': page},
            );
        final RemoteMovieResponse data = RemoteMovieResponse.fromJson(response);
        return data.results
            .map(
              (RemoteMovieModel m) =>
                  RemoteMovieMapper.toEntity(m, _imageUrlResolver),
            )
            .toList();
      });

  @override
  Future<Result<List<Movie>>> searchMovies(String query) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService
            .request<Map<String, dynamic>>(
              'search/movie',
              method: HttpMethod.get,
              queryParameters: <String, dynamic>{'query': query},
            );
        final RemoteMovieResponse data = RemoteMovieResponse.fromJson(response);
        return data.results
            .map(
              (RemoteMovieModel m) =>
                  RemoteMovieMapper.toEntity(m, _imageUrlResolver),
            )
            .toList();
      });

  @override
  Future<Result<List<Actor>>> getMovieCast(int movieId) =>
      executeRepositoryCall(() async {
        final Map<String, dynamic> response = await _httpService
            .request<Map<String, dynamic>>(
              'movie/$movieId/credits',
              method: HttpMethod.get,
            );
        final RemoteCastResponse data = RemoteCastResponse.fromJson(response);
        return data.cast
            .map(
              (RemoteActorModel a) =>
                  RemoteActorMapper.toEntity(a, _imageUrlResolver),
            )
            .toList();
      });
}
