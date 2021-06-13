import 'package:app/imports.dart';

class LoginUseCase {
  final UserLocalRepository userRepository;

  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository, this.userRepository);

  Future<Result<User>> call(LoginModel model) async {
    Result<User> result = await loginRepository.login(model);

    if(result.isSuccess) {
      User user = result.data;
      userRepository.save(user);
    }

    return result;
  }
}
