import '../../../../test_imports.dart';

void main() {
  late UserLocalRepository userRepository;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    initGetItTest();

    userRepository = MockUserLocalRepository();
    logoutUseCase = LogoutUseCase(userRepository);
  });

  testWidgets('should clear all user data', (WidgetTester tester) async {

    // act
    await logoutUseCase();

    // assert
    verify(userRepository.clear());
  });
}
