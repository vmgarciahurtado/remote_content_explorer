import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/core/network/error_handler/failures.dart';
import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/core/network/result.dart';

void main() {
  group('executeApiCall', () {
    test(
      'given a successful call '
      'when executed '
      'then returns the value with no failure',
      () async {
        // given
        Future<String> call() async => 'data';

        // when
        final Result<String> result = await executeApiCall(call);

        // then
        expect(result, isA<Success<String>>());
        expect((result as Success<String>).data, 'data');
      },
    );

    test(
      'given a DioException with status 401 '
      'when executed '
      'then returns UnauthorizedFailure',
      () async {
        // given
        Future<String> call() async => throw _dioException(401);

        // when
        final Result<String> result = await executeApiCall(call);

        // then
        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<UnauthorizedFailure>(),
        );
      },
    );

    test(
      'given a DioException with status 404 '
      'when executed '
      'then returns NotFoundFailure',
      () async {
        // given
        Future<String> call() async => throw _dioException(404);

        // when
        final Result<String> result = await executeApiCall(call);

        // then
        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<NotFoundFailure>(),
        );
      },
    );

    test(
      'given a DioException with status 500 '
      'when executed '
      'then returns ServerErrorFailure',
      () async {
        // given
        Future<String> call() async => throw _dioException(500);

        // when
        final Result<String> result = await executeApiCall(call);

        // then
        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<ServerErrorFailure>(),
        );
      },
    );

    test(
      'given a DioException with no status code '
      'when executed '
      'then returns NetworkFailure',
      () async {
        // given
        Future<String> call() async =>
            throw DioException(requestOptions: RequestOptions());

        // when
        final Result<String> result = await executeApiCall(call);

        // then
        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<NetworkFailure>(),
        );
      },
    );

    test(
      'given an unknown exception '
      'when executed '
      'then returns UnknownFailure',
      () async {
        // given
        Future<String> call() async => throw Exception('unexpected');

        // when
        final Result<String> result = await executeApiCall(call);

        // then
        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<UnknownFailure>(),
        );
      },
    );
  });
}

DioException _dioException(int statusCode) => DioException(
  requestOptions: RequestOptions(),
  response: Response<dynamic>(
    requestOptions: RequestOptions(),
    statusCode: statusCode,
  ),
);
