import 'package:dio/dio.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/cast_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_response.dart';

class MovieRemoteDatasource {
  MovieRemoteDatasource(this._dio);

  final Dio _dio;

  Future<MovieResponse> getNowPlaying({int page = 1}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'movie/now_playing',
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data!);
  }

  Future<MovieResponse> getPopular({int page = 1}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'movie/popular',
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data!);
  }

  Future<CastResponse> getMovieCast(int movieId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'movie/$movieId/credits',
    );
    return CastResponse.fromJson(response.data!);
  }

  Future<MovieResponse> searchMovies({required String query}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'search/movie',
      queryParameters: {'query': query},
    );
    return MovieResponse.fromJson(response.data!);
  }
}
