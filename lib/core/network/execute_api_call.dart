import 'package:dio/dio.dart';

import 'error_handler/failure.dart';
import 'error_handler/network_failure.dart';
import 'error_handler/not_found_failure.dart';
import 'error_handler/server_error_failure.dart';
import 'error_handler/unauthorized_failure.dart';
import 'error_handler/unknown_failure.dart';

typedef Result<T> = Future<(T?, Failure?)>;

Result<T> executeApiCall<T>(Future<T> Function() call) async {
  try {
    return (await call(), null);
  } on DioException catch (e) {
    return (null, _mapDioError(e));
  } catch (_) {
    return (null, const UnknownFailure());
  }
}

Failure _mapDioError(DioException e) => switch (e.response?.statusCode) {
  401 => const UnauthorizedFailure(),
  404 => const NotFoundFailure(),
  final int s when s >= 500 => const ServerErrorFailure(),
  _ => const NetworkFailure(),
};
