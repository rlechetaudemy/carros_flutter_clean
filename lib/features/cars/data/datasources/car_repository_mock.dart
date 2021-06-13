import 'dart:convert';

import 'package:app/imports.dart';

// coverage:ignore-start
class CarRepositoryMock implements CarRepository {
  Future<Result<List<Car>>> getCars() async {

    try {
      await Future.delayed(Duration(milliseconds: 500));

      // Ok
      return Result.success(await _getCars());

      // Timeout
    //  var url = 'https://mocky.free.beeceptor.com/timeout';
    //  print("GET > $url");
    //  await http.get(url, timeOutSeconds: 3);

      // vazio
      // return [];

    } on TimeoutException {
      return Result.failure(TimeoutFailure());
    } catch(e) {
      return Result.failure(ApiFailure());
    }
  }

  Future<List<Car>> _getCars() async {
    String json = await rootBundle.loadString("assets/mock/cars.json");
    List list = jsonDecode(json);
    return list.map<Car>((map) => Car.fromMap(map)).toList();
  }

  @override
  Future<Result<Car>> getCarById(int id) async {
    String json = await rootBundle.loadString("assets/mock/car.json");
    return Result.success(Car.fromMap(jsonDecode(json)));
  }
}
// coverage:ignore-end
