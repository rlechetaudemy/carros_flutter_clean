import 'dart:convert';

import 'package:app/imports.dart';
import 'package:http/http.dart';

abstract class CarApi {
  static final URL = 'https://carros-springboot.herokuapp.com/api/v1/carros';

  Future<List<Car>> getCars();

  Future<Car> getCarById(int id);
}

class CarApiImpl implements CarApi {
  final Client http;

  CarApiImpl(this.http);

  Future<List<Car>> getCars() async {
    String url = CarApi.URL;

    print("GET > $url");

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);

      List<Car> cars = list.map<Car>((map) => Car.fromMap(map)).toList();

      return cars;
    }

    throw ApiException.fromResponse(response);
  }

  Future<Car> getCarById(int id) async {
    final url = '${CarApi.URL}/$id';

    print("GET > $url");

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      return Car.fromMap(map);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    }

    throw ApiException.fromResponse(response);
  }
}
