import 'package:app/imports.dart';

class CarRepositoryImpl implements CarRepository {
  final CarApi api;

  CarRepositoryImpl(this.api);

  Future<Result<List<Car>>> getCars() async {
    try {
      List<Car> cars = await api.getCars();

      return Result.success(cars);
    } on TimeoutException {
      return Result.failure(TimeoutFailure());
    } catch(e) {
      return Result.failure(ApiFailure());
    }
  }

  Future<Result<Car>> getCarById(int id) async {
    try {
      Car car = await api.getCarById(id);
      return Result.success(car);
    } on TimeoutException {
      return Result.failure(TimeoutFailure());
    } catch(e) {
      return Result.failure(ApiFailure());
    }
  }
}
