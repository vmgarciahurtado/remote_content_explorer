import 'failure.dart';

final class ServerErrorFailure extends Failure {
  const ServerErrorFailure();

  @override
  String get userMessage => 'Error del servidor. Intenta de nuevo más tarde.';
}
