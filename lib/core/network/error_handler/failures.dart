sealed class Failure {
  const Failure();
  String get userMessage;
}

final class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  String get userMessage => 'Sin conexión a internet';
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure();

  @override
  String get userMessage => 'Recurso no encontrado';
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();

  @override
  String get userMessage => 'Sesión expirada';
}

final class ServerErrorFailure extends Failure {
  const ServerErrorFailure();

  @override
  String get userMessage => 'Error del servidor. Intenta de nuevo más tarde.';
}

final class UnknownFailure extends Failure {
  final String? message;
  const UnknownFailure([this.message]);

  @override
  String get userMessage => message ?? 'Error inesperado';
}
