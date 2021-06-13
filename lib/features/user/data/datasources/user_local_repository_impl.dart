import 'package:app/imports.dart';

class UserLocalRepositoryImpl implements UserLocalRepository {
  Prefs prefs;
  AppState appState;

  UserLocalRepositoryImpl(this.prefs, this.appState);

  Future<void> save(User user) async {
    prefs.setString("user.prefs", user.toJson());
    appState.user = user;
  }

  @override
  Future<void> clear() async {
    prefs.setString("user.prefs", "");
    appState.user = null;
  }
}