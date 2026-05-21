import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interceptors/logging_interceptor.dart';

// NOTA: Por efectos prácticos, el API key de The Movie DB se hardcodea aquí.
// Este key será dado de baja en cuanto se revise el código de la aplicación.
const _tmdbApiKey = '9b31efe96a35c640012f380f12ee2b86';
const _tmdbBaseUrl = 'https://api.themoviedb.org/3/';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  dio.options.baseUrl = _tmdbBaseUrl;
  dio.options.queryParameters = {'api_key': _tmdbApiKey, 'language': 'es-ES'};
  dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
  dio.options.contentType = 'application/json';
  dio.interceptors.add(LoggingInterceptor());
  return dio;
}
