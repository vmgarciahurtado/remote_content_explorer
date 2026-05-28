import 'failure.dart';

final class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  String get userMessage => 'Sin conexión a internet';
}
