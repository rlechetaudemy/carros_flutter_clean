import 'dart:convert';

import 'package:app/imports.dart';

import 'fixture_reader.dart';

List<Car> getMockCars() {
  String json = mockFile("cars.json");
  return jsonDecode(json).map<Car>((map) => Car.fromMap(map)).toList();
}

Car getMockCar() {
  return Car.fromMap(jsonDecode(mockFile("car.json")));
}

User getMockUser() {
  return User.fromJson(jsonDecode(mockFile("login.json")));
}
