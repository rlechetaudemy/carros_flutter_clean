import '../../../../test_imports.dart';

void main() {
  late LogoutViewModel logoutViewModel;
  late LogoutUseCase useCase;

  setUp(() {
    useCase = MockLogoutUseCase();
    logoutViewModel = LogoutViewModel(useCase);
  });

  testWidgets('should call usecase logout', (WidgetTester tester) async {
    // act
    logoutViewModel.logout();

    // assert
    verify(useCase());
  });
}
