import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_content_explorer/core/errors/failures.dart';
import 'package:remote_content_explorer/core/services/http/dio/dio_http_service.dart';
import 'package:remote_content_explorer/core/services/http/http_method.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late DioHttpService dioHttpService;

  setUp(() {
    mockDio = MockDio();
    dioHttpService = DioHttpService(mockDio);
    registerFallbackValue(Options());
  });

  group('DioHttpService', () {
    const String tPath = 'test/path';
    const HttpMethod tMethod = HttpMethod.get;

    test('should return data when the request is successful', () async {
      // Arrange
      final Map<String, dynamic> tData = <String, dynamic>{'key': 'value'};
      final Response<Map<String, dynamic>> tResponse =
          Response<Map<String, dynamic>>(
            data: tData,
            statusCode: 200,
            requestOptions: RequestOptions(path: tPath),
          );

      when(
        () => mockDio.request<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponse);

      // Act
      final Map<String, dynamic> result = await dioHttpService
          .request<Map<String, dynamic>>(
            tPath,
            method: tMethod,
          );

      // Assert
      expect(result, tData);
      verify(
        () => mockDio.request<Map<String, dynamic>>(
          tPath,
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    group('Exception handling', () {
      test(
        'should throw ConnectionFailure when DioException is connection error',
        () async {
          // Arrange
          final DioException tException = DioException(
            requestOptions: RequestOptions(path: tPath),
            type: DioExceptionType.connectionError,
          );
          when(
            () => mockDio.request<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(tException);

          // Act
          final Future<dynamic> call = dioHttpService.request<dynamic>(
            tPath,
            method: tMethod,
          );

          // Assert
          expect(() => call, throwsA(isA<ConnectionFailure>()));
        },
      );

      test(
        'should throw UnauthorizedFailure when status code is 401',
        () async {
          // Arrange
          final DioException tException = DioException(
            requestOptions: RequestOptions(path: tPath),
            response: Response<dynamic>(
              statusCode: 401,
              requestOptions: RequestOptions(path: tPath),
            ),
          );
          when(
            () => mockDio.request<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(tException);

          // Act
          final Future<dynamic> call = dioHttpService.request<dynamic>(
            tPath,
            method: tMethod,
          );

          // Assert
          expect(() => call, throwsA(isA<UnauthorizedFailure>()));
        },
      );

      test('should throw NotFoundFailure when status code is 404', () async {
        // Arrange
        final DioException tException = DioException(
          requestOptions: RequestOptions(path: tPath),
          response: Response<dynamic>(
            statusCode: 404,
            requestOptions: RequestOptions(path: tPath),
          ),
        );
        when(
          () => mockDio.request<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenThrow(tException);

        // Act
        final Future<dynamic> call = dioHttpService.request<dynamic>(
          tPath,
          method: tMethod,
        );

        // Assert
        expect(() => call, throwsA(isA<NotFoundFailure>()));
      });

      test('should throw ServerFailure when status code is 500', () async {
        // Arrange
        final DioException tException = DioException(
          requestOptions: RequestOptions(path: tPath),
          response: Response<dynamic>(
            statusCode: 500,
            requestOptions: RequestOptions(path: tPath),
          ),
        );
        when(
          () => mockDio.request<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenThrow(tException);

        // Act
        final Future<dynamic> call = dioHttpService.request<dynamic>(
          tPath,
          method: tMethod,
        );

        // Assert
        expect(() => call, throwsA(isA<ServerFailure>()));
      });

      test(
        'should throw UnexpectedFailure when DioException has no response/statusCode',
        () async {
          // Arrange
          final DioException tException = DioException(
            requestOptions: RequestOptions(path: tPath),
          );
          when(
            () => mockDio.request<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(tException);

          // Act
          final Future<dynamic> call = dioHttpService.request<dynamic>(
            tPath,
            method: tMethod,
          );

          // Assert
          expect(() => call, throwsA(isA<UnexpectedFailure>()));
        },
      );

      test(
        'should throw UnexpectedFailure when non-DioException occurs',
        () async {
          // Arrange
          when(
            () => mockDio.request<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(Exception('General exception'));

          // Act
          final Future<dynamic> call = dioHttpService.request<dynamic>(
            tPath,
            method: tMethod,
          );

          // Assert
          expect(() => call, throwsA(isA<UnexpectedFailure>()));
        },
      );
    });
  });
}
