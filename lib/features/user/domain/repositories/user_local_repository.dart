import 'package:app/features/login/domain/entities/user.dart';

// Repositoru to save logged user
abstract class UserLocalRepository {

  Future<void> save(User user);

  Future<void> clear();
}