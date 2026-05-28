import 'failure.dart';

final class UnknownFailure extends Failure {
  const UnknownFailure([this.message]);
  final String? message;

  @override
  String get userMessage => message ?? 'Error inesperado';
}
