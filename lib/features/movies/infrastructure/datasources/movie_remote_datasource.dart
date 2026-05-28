import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/dio_provider.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/cast_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_response.dart';

class MovieRemoteDatasource {
  MovieRemoteDatasource(this._dio);

  final Dio _dio;

  Future<MovieResponse> getNowPlaying({int page = 1}) async {
    final Response<Map<String, dynamic>> response = await _dio
        .get<Map<String, dynamic>>(
          'movie/now_playing',
          queryParameters: <String, dynamic>{'page': page},
        );
    return MovieResponse.fromJson(response.data!);
  }

  Future<MovieResponse> getPopular({int page = 1}) async {
    final Response<Map<String, dynamic>> response = await _dio
        .get<Map<String, dynamic>>(
          'movie/popular',
          queryParameters: <String, dynamic>{'page': page},
        );
    return MovieResponse.fromJson(response.data!);
  }

  Future<CastResponse> getMovieCast(int movieId) async {
    final Response<Map<String, dynamic>> response = await _dio
        .get<Map<String, dynamic>>(
          'movie/$movieId/credits',
        );
    return CastResponse.fromJson(response.data!);
  }

  Future<MovieResponse> searchMovies({required String query}) async {
    final Response<Map<String, dynamic>> response = await _dio
        .get<Map<String, dynamic>>(
          'search/movie',
          queryParameters: <String, dynamic>{'query': query},
        );
    return MovieResponse.fromJson(response.data!);
  }
}

final Provider<MovieRemoteDatasource> movieRemoteDatasourceProvider =
    Provider<MovieRemoteDatasource>(
      (Ref ref) => MovieRemoteDatasource(ref.watch(dioProvider)),
    );
