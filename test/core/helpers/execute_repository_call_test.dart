import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/core/errors/failures.dart';
import 'package:remote_content_explorer/core/helpers/execute_repository_call.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';

void main() {
  group('executeRepositoryCall', () {
    test(
      'given a successful call when executed '
      'then returns the value with no failure',
      () async {
        Future<String> call() async => 'data';

        final Result<String> result = await executeRepositoryCall(call);

        expect(result, isA<Success<String>>());
        expect((result as Success<String>).data, 'data');
      },
    );

    test(
      'given an UnauthorizedFailure when executed '
      'then returns UnauthorizedFailure directly',
      () async {
        Future<String> call() async => throw const UnauthorizedFailure();

        final Result<String> result = await executeRepositoryCall(call);

        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<UnauthorizedFailure>(),
        );
      },
    );

    test(
      'given a NotFoundFailure when executed '
      'then returns NotFoundFailure directly',
      () async {
        Future<String> call() async => throw const NotFoundFailure();

        final Result<String> result = await executeRepositoryCall(call);

        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<NotFoundFailure>(),
        );
      },
    );

    test(
      'given a ServerFailure when executed '
      'then returns ServerFailure directly',
      () async {
        Future<String> call() async => throw const ServerFailure();

        final Result<String> result = await executeRepositoryCall(call);

        expect(result, isA<FailureResult<String>>());
        expect((result as FailureResult<String>).failure, isA<ServerFailure>());
      },
    );

    test(
      'given a ConnectionFailure when executed '
      'then returns ConnectionFailure directly',
      () async {
        Future<String> call() async => throw const ConnectionFailure();

        final Result<String> result = await executeRepositoryCall(call);

        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<ConnectionFailure>(),
        );
      },
    );

    test(
      'given an unknown exception when executed '
      'then returns UnexpectedFailure',
      () async {
        Future<String> call() async => throw Exception('unexpected');

        final Result<String> result = await executeRepositoryCall(call);

        expect(result, isA<FailureResult<String>>());
        expect(
          (result as FailureResult<String>).failure,
          isA<UnexpectedFailure>(),
        );
      },
    );
  });
}
