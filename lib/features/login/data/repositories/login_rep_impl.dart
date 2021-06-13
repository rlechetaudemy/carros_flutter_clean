import 'package:app/features/login/data/datasources/login_api.dart';
import 'package:app/features/login/domain/entities/user.dart';
import 'package:app/features/login/domain/repositories/login_rep.dart';
import 'package:app/imports.dart';

import '../../presentation/viewmodel/login_viewmodel.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginApi api;

  LoginRepositoryImpl(this.api);

  Future<Result<User>> login(LoginModel model) async {
    try {
      User user = await api.login(model.login, model.password);
      return Result.success(user);
    } on ApiMessageException catch(e) {
      return Result.failure(MessageFailure(e.msg));
    } catch(e) {
      return Result.failure(ApiFailure());
    }
  }
}
