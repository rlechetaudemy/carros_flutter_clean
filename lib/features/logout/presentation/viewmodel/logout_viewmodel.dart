import 'package:app/features/logout/domain/usecases/logout_use_case.dart';

class LogoutViewModel {
  LogoutUseCase logoutUseCase;

  LogoutViewModel(this.logoutUseCase);

  Future<void> logout() => logoutUseCase();
}
