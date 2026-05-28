import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/network/interceptors/logging_interceptor.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  late LoggingInterceptor interceptor;

  setUp(() {
    interceptor = LoggingInterceptor();
  });

  group('LoggingInterceptor', () {
    test(
      'given an outgoing request without body '
      'when onRequest is called '
      'then the request is forwarded via handler.next',
      () {
        // given
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'GET',
        );
        final MockRequestInterceptorHandler handler =
            MockRequestInterceptorHandler();

        // when
        interceptor.onRequest(options, handler);

        // then
        verify(() => handler.next(options)).called(1);
      },
    );

    test(
      'given an outgoing request with a body '
      'when onRequest is called '
      'then the body is logged and the request is forwarded',
      () {
        // given
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          data: <String, String>{'key': 'value'},
        );
        final MockRequestInterceptorHandler handler =
            MockRequestInterceptorHandler();

        // when
        interceptor.onRequest(options, handler);

        // then
        verify(() => handler.next(options)).called(1);
      },
    );

    test(
      'given an incoming response '
      'when onResponse is called '
      'then the response is forwarded via handler.next',
      () {
        // given
        final RequestOptions options = RequestOptions(path: '/test');
        final Response<dynamic> response = Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, String>{'result': 'ok'},
        );
        final MockResponseInterceptorHandler handler =
            MockResponseInterceptorHandler();

        // when
        interceptor.onResponse(response, handler);

        // then
        verify(() => handler.next(response)).called(1);
      },
    );

    test(
      'given a request error without response data '
      'when onError is called '
      'then the error is forwarded via handler.next',
      () {
        // given
        final RequestOptions options = RequestOptions(path: '/test');
        final DioException error = DioException(
          requestOptions: options,
          response: Response<dynamic>(
            requestOptions: options,
            statusCode: 500,
          ),
        );
        final MockErrorInterceptorHandler handler =
            MockErrorInterceptorHandler();

        // when
        interceptor.onError(error, handler);

        // then
        verify(() => handler.next(error)).called(1);
      },
    );

    test(
      'given a request error with response data '
      'when onError is called '
      'then the error data is logged and the error is forwarded',
      () {
        // given
        final RequestOptions options = RequestOptions(path: '/test');
        final DioException error = DioException(
          requestOptions: options,
          response: Response<dynamic>(
            requestOptions: options,
            statusCode: 500,
            data: <String, String>{'error': 'Internal Server Error'},
          ),
        );
        final MockErrorInterceptorHandler handler =
            MockErrorInterceptorHandler();

        // when
        interceptor.onError(error, handler);

        // then
        verify(() => handler.next(error)).called(1);
      },
    );
  });
}
