import 'package:remote_content_explorer/core/errors/failures.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}

extension ResultX<T> on Result<T> {
  /// Returns [Success] value or throws the contained [Failure].
  ///
  /// It's propagate the typed [Failure] without duplicating the pattern match.
  T getOrThrow() => switch (this) {
    Success<T>(data: final T data) => data,
    FailureResult<T>(failure: final Failure failure) => throw failure,
  };
}
