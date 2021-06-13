
import 'package:app/imports.dart';

abstract class CarRepository {
  Future<Result<List<Car>>> getCars();

  Future<Result<Car>> getCarById(int id);
}
