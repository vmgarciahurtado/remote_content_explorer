import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/core/network/execute_api_call.dart';
import 'package:remote_content_explorer/core/network/failure.dart';

void main() {
  group('executeApiCall', () {
    test(
      'given a successful call '
      'when executed '
      'then returns Right with the value',
      () async {
        // given
        Future<String> call() async => 'data';

        // when
        final result = await executeApiCall(call);

        // then
        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Expected Right'), (v) => expect(v, 'data'));
      },
    );

    test(
      'given a DioException with status 401 '
      'when executed '
      'then returns Left(UnauthorizedFailure)',
      () async {
        // given
        Future<String> call() async => throw _dioException(401);

        // when
        final result = await executeApiCall(call);

        // then
        expect(result.isLeft(), isTrue);
        result.fold((f) => expect(f, isA<UnauthorizedFailure>()), (_) => fail(''));
      },
    );

    test(
      'given a DioException with status 404 '
      'when executed '
      'then returns Left(NotFoundFailure)',
      () async {
        // given
        Future<String> call() async => throw _dioException(404);

        // when
        final result = await executeApiCall(call);

        // then
        expect(result.isLeft(), isTrue);
        result.fold((f) => expect(f, isA<NotFoundFailure>()), (_) => fail(''));
      },
    );

    test(
      'given a DioException with status 500 '
      'when executed '
      'then returns Left(ServerErrorFailure)',
      () async {
        // given
        Future<String> call() async => throw _dioException(500);

        // when
        final result = await executeApiCall(call);

        // then
        expect(result.isLeft(), isTrue);
        result.fold((f) => expect(f, isA<ServerErrorFailure>()), (_) => fail(''));
      },
    );

    test(
      'given a DioException with no status code '
      'when executed '
      'then returns Left(NetworkFailure)',
      () async {
        // given
        Future<String> call() async =>
            throw DioException(requestOptions: RequestOptions(path: ''));

        // when
        final result = await executeApiCall(call);

        // then
        expect(result.isLeft(), isTrue);
        result.fold((f) => expect(f, isA<NetworkFailure>()), (_) => fail(''));
      },
    );

    test(
      'given an unknown exception '
      'when executed '
      'then returns Left(UnknownFailure)',
      () async {
        // given
        Future<String> call() async => throw Exception('unexpected');

        // when
        final result = await executeApiCall(call);

        // then
        expect(result.isLeft(), isTrue);
        result.fold((f) => expect(f, isA<UnknownFailure>()), (_) => fail(''));
      },
    );
  });
}

DioException _dioException(int statusCode) => DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: statusCode,
      ),
    );
