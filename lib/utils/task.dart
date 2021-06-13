import 'package:app/imports.dart';

typedef Task<T> = Future<T> Function();

/// Template to execute some action
/// So we can make sure that all exceptions are handled, in case of any error.
Future<void> exec<T>(
  Task<Result<T>> task, {
  bool offline = false,
  required Function(T response) onSuccess,
  required Function(String error) onError,
  Function? onComplete,
}) async {
  try {
    if (!offline) {
      if (await isOffline()) {
        onError(ErrorState.noInternet().msg);
        return null;
      }
    }

    Result<T> result = await task();
    print(result);

    if(result.isSuccess) {
      onSuccess(result.data!);
    } else {
      onError(ErrorState.create(result.error).msg);
    }

  } catch (e) {
    onError(ErrorState.create(e).msg);
  } finally {
    onComplete?.call();
  }
}
