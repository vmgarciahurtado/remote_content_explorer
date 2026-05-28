import 'package:dio/dio.dart';

import 'error_handler/failures.dart';
import 'result.dart';

Future<Result<T>> executeApiCall<T>(Future<T> Function() call) async {
  try {
    final T data = await call();
    return Success<T>(data);
  } on DioException catch (e) {
    return FailureResult<T>(_mapDioError(e));
  } catch (_) {
    return FailureResult<T>(const UnknownFailure());
  }
}

Failure _mapDioError(DioException e) => switch (e.response?.statusCode) {
  401 => const UnauthorizedFailure(),
  404 => const NotFoundFailure(),
  final int s when s >= 500 => const ServerErrorFailure(),
  _ => const NetworkFailure(),
};
