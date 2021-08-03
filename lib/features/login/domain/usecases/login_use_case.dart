import 'package:app/imports.dart';

abstract class LoginUseCase {
  Future<Result<User>> call(LoginModel model);
}

class LoginUseCaseImpl implements LoginUseCase {
  final UserLocalRepository userLocalRepository;

  final LoginRepository loginRepository;

  LoginUseCaseImpl(this.loginRepository, this.userLocalRepository);

  Future<Result<User>> call(LoginModel model) async {
    Result<User> result = await loginRepository.login(model);

    if(result.isSuccess) {
      User user = result.data;
      userLocalRepository.save(user);
    }

    return result;
  }
}
