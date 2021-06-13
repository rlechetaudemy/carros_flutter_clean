import 'package:app/imports.dart';

extension ViewStateExtension on ViewState {
  /// Useful method to call some task and set the result in the ViewState automatically.
  Future<void> update<T>(
      Task<Result<T>> task, {
        bool offline = false,
      }) async {
    try {
      if (!offline && await isOffline()) {
        this.error = ErrorState.noInternet();
        return;
      }

      this.loading = true;

      Result<T> result = await task();

      if (result.isSuccess) {
        this.value = result.data;
      } else {
        this.error = ErrorState.create(result.error);
      }
    } catch (e) {
      this.error = ErrorState.create(e);
    }
  }
}