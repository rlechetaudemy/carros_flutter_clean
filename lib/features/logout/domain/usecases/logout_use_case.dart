import 'package:app/imports.dart';

class LogoutUseCase {
  final UserLocalRepository userLocalRepository;

  LogoutUseCase(this.userLocalRepository);

  Future<void> call() => userLocalRepository.clear();
}
