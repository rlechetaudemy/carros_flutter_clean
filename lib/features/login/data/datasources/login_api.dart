import 'dart:convert';

import 'package:app/core/data/exceptions/server_exception.dart';
import 'package:app/imports.dart';
import 'package:http/http.dart';

abstract class LoginApi {
  static var URL = 'https://carros-springboot.herokuapp.com/api/v2/login';

  Future<User> login(String login, String password);
}

// TODO LoginDataSource ?
class LoginApiImpl implements LoginApi {
  final Client http;

  LoginApiImpl(this.http);

  Future<User> login(String login, String password) async {
    Map params = {"username": login, "password": password};

    String s = json.encode(params);
    print(LoginApi.URL);
    print(">> $s");

    var response = await http.post(Uri.parse(LoginApi.URL), body: s, headers: {
      'Content-Type': 'application/json',
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      return User.fromJson(mapResponse);
    }

    if (response.statusCode == 401) {
      Map mapResponse = json.decode(response.body);
      // 401 = { "error": "Login incorreto" }
      String msg = mapResponse["error"];

      throw ApiMessageException(statusCode: response.statusCode, msg: msg);
    }

    throw ApiException.fromResponse(response);
  }
}
