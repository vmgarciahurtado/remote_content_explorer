import 'package:dio/dio.dart';

import 'failure.dart';

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
