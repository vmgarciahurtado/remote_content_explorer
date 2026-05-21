import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

typedef Result<T> = Future<Either<Failure, T>>;

Result<T> executeApiCall<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } on DioException catch (e) {
    final int? status = e.response?.statusCode;
    return Left(switch (status) {
      401 => const UnauthorizedFailure(),
      404 => const NotFoundFailure(),
      final int s when s >= 500 => const ServerErrorFailure(),
      _ => const NetworkFailure(),
    });
  } catch (_) {
    return const Left(UnknownFailure());
  }
}
