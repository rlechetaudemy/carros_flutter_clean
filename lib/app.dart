import 'package:app/imports.dart';

class AppState {
  User? _user;

  User? get user => _user;

  set user(User? user) => this._user = user;
}
