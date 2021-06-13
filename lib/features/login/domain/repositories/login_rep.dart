import 'package:app/features/login/domain/entities/user.dart';
import 'package:app/imports.dart';

import '../../presentation/viewmodel/login_viewmodel.dart';

abstract class LoginRepository {
  Future<Result<User>> login(LoginModel model);
}
