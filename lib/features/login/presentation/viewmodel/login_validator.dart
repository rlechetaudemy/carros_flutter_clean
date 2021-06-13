import 'package:app/imports.dart';

class LoginValidator {
  var login$ = GenericStream<String?>();
  var password$ = GenericStream<String?>();

  bool validate(LoginModel model) {
    var loginOk     = validateLogin(model.login);
    var passwordOk  = validatePassword(model.password);
    return loginOk && passwordOk;
  }

  bool validateLogin(String? text) {
    String? error;
    if (text?.isEmpty ?? true) {
      error = R.strings.loginRequired;
    }
    login$.add(error);
    return error == null;
  }

  bool validatePassword(String? text) {
    String? error;
    if (text?.isEmpty ?? true) {
      error = R.strings.passwordRequired;
    } else if ((text?.length ?? 0) < 3) {
      error = R.strings.passwordMinLength;
    }
    password$.add(error);
    return error == null;
  }

  void close() {
    login$.close();
    password$.close();
  }
}
