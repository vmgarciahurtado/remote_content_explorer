sealed class Failure {
  const Failure();

  String get userMessage => switch (this) {
    NetworkFailure() => 'Sin conexión a internet',
    UnauthorizedFailure() => 'Sesión expirada',
    NotFoundFailure() => 'Recurso no encontrado',
    ServerErrorFailure() => 'Error del servidor. Intenta de nuevo más tarde.',
    UnknownFailure(:final message) => message ?? 'Error inesperado',
  };
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

final class ServerErrorFailure extends Failure {
  const ServerErrorFailure();
}

final class UnknownFailure extends Failure {
  const UnknownFailure([this.message]);
  final String? message;
}
