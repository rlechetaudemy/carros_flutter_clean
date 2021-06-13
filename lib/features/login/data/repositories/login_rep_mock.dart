import 'dart:convert';

import 'package:app/imports.dart';

// coverage:ignore-start

final mock_delay = Duration(milliseconds: 200);

class LoginRepositoryMock implements LoginRepository {
  @override
  Future<Result<User>> login(LoginModel model) async {
    await Future.delayed(Duration(milliseconds: 500));

    return Result.success(await getUser(model));
  }

  Future<User> getUser(LoginModel model) async {
    String json = await rootBundle.loadString("assets/mock/login.json");
    return User.fromJson(jsonDecode(json));
  }
}
// coverage:ignore-end
