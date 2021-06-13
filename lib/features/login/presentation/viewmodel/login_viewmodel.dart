import 'package:app/features/login/domain/usecases/login_use_case.dart';
import 'package:app/features/login/presentation/viewmodel/login_validator.dart';
import 'package:app/imports.dart';
import 'package:flutter/foundation.dart';

abstract class LoginView {
  void onLoginSuccess();

  void onLoginError(String msg);
}

class LoginModel {
  String login = "";
  String password = "";
}

class LoginViewModel {
  final LoginUseCase loginUseCase;

  var model = LoginModel();

  // -- View --
  late LoginView view;

  // -- Form --
  final tLogin = TextEditingController();
  final tSenha = TextEditingController();

  // -- Streams --
  final loading$ = BooleanStream();

  // -- Validator --
  final validator = LoginValidator();

  LoginViewModel(this.loginUseCase);

  bool validate() => validator.validate(model);

  Future<void> login() async {
    if (!validate()) {
      return;
    }

    loading$.add(true);

    await exec<User>(
      () => loginUseCase(model),
      onSuccess: (user) => view.onLoginSuccess(),
      onError: (error)  => view.onLoginError(error),
      onComplete: ()    => loading$.add(false),
    );
  }

  void setLogin(String login) {
    model.login = login;
    validator.validateLogin(login);
  }

  void setPassword(String password) {
    model.password = password;
    validator.validatePassword(password);
  }

  void fake() {
    if (kDebugMode) {
      tLogin.text = model.login = "user";
      tSenha.text = model.password = "123";
    }
  }

  void close() {
    loading$.close();
    validator.close();
  }
}
