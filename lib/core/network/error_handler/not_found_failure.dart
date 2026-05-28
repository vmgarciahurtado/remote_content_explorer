import 'failure.dart';

final class NotFoundFailure extends Failure {
  const NotFoundFailure();

  @override
  String get userMessage => 'Recurso no encontrado';
}
