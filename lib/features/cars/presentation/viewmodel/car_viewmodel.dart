import 'dart:async';

import 'package:app/imports.dart';

class CarViewModel /*extends BaseViewModel<Car>*/ {
  GetCarById _getCarById;

  final state = ViewState<Car>();

  CarViewModel(this._getCarById);

  //Future<void> fetch(int id) async => doAsync(() => _getCarById(id));

  Future<void> fetch(int id) async {
    if (await isOffline()) {
      state.error = ErrorState.noInternet();
      return;
    }

    state.loading = true;

    Result result = await _getCarById(id);

    result.when(
      success: (data) => state.value = data,
      failure: (error) => state.error = ErrorState.create(error),
    );
  }

  void close() {
    state.close();
  }
}
