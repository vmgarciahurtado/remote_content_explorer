import 'failure.dart';

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();

  @override
  String get userMessage => 'Sesión expirada';
}
