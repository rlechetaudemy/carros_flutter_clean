import 'package:app/imports.dart';

class CarsViewModel {
  GetCars _getCars;

  CarsViewModel(this._getCars);

  final state = ViewState<List<Car>>();

  // Future<void> fetch() => state.update(() => _getCars());

  Future<void> fetch() async {
    if(await isOffline()) {
      state.error = ErrorState.noInternet();
      return;
    }

    state.loading = true;

    Result<List<Car>> result = await _getCars();

    result.when(
      success: (data) => state.value = data,
      failure: (error) => state.error = ErrorState.create(error)
    );
  }

  void close() {
    state.close();
  }
}
