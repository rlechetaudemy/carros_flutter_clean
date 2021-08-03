import 'package:app/imports.dart';

class GetCars {
  CarRepository repository;

  GetCars(this.repository);

  Future<Result<List<Car>>> call() => repository.getCars();
}

class GetCarById {
  CarRepository repository;

  GetCarById(this.repository);

  Future<Result<Car>> call(int id) => repository.getCarById(id);
}
