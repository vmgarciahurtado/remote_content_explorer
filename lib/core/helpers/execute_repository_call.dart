import 'package:remote_content_explorer/core/errors/failures.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';

Future<Result<T>> executeRepositoryCall<T>(Future<T> Function() call) async {
  try {
    final T data = await call();
    return Success<T>(data);
  } on Failure catch (e) {
    return FailureResult<T>(e);
  } catch (e) {
    return FailureResult<T>(UnexpectedFailure(e.toString()));
  }
}
