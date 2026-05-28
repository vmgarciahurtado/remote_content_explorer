import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/core/network/error_handler/network_failure.dart';
import 'package:remote_content_explorer/core/network/error_handler/not_found_failure.dart';
import 'package:remote_content_explorer/core/network/error_handler/server_error_failure.dart';
import 'package:remote_content_explorer/core/network/error_handler/unauthorized_failure.dart';
import 'package:remote_content_explorer/core/network/error_handler/unknown_failure.dart';

void main() {
  group('Failure.userMessage', () {
    test(
      'given NetworkFailure '
      'when userMessage is accessed '
      'then returns the no-connection message',
      () {
        expect(const NetworkFailure().userMessage, 'Sin conexión a internet');
      },
    );

    test(
      'given UnauthorizedFailure '
      'when userMessage is accessed '
      'then returns the expired-session message',
      () {
        expect(const UnauthorizedFailure().userMessage, 'Sesión expirada');
      },
    );

    test(
      'given NotFoundFailure '
      'when userMessage is accessed '
      'then returns the not-found message',
      () {
        expect(const NotFoundFailure().userMessage, 'Recurso no encontrado');
      },
    );

    test(
      'given ServerErrorFailure '
      'when userMessage is accessed '
      'then returns the server-error message',
      () {
        expect(
          const ServerErrorFailure().userMessage,
          'Error del servidor. Intenta de nuevo más tarde.',
        );
      },
    );

    test(
      'given UnknownFailure with a custom message '
      'when userMessage is accessed '
      'then returns the custom message',
      () {
        expect(
          const UnknownFailure('Algo salió mal').userMessage,
          'Algo salió mal',
        );
      },
    );

    test(
      'given UnknownFailure without a message '
      'when userMessage is accessed '
      'then returns the generic fallback message',
      () {
        expect(const UnknownFailure().userMessage, 'Error inesperado');
      },
    );
  });
}
