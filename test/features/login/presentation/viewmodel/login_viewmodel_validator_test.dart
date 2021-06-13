import '../../../../test_imports.dart';

void main() {
  late LoginUseCase loginUseCase;
  late LoginRepository repository;
  late LoginViewModel viewModel;
  late MockLoginView loginView;

  setUp(() {
    initGetItTest();

    repository = MockLoginRepository();
    loginUseCase = LoginUseCase(repository, MockUserLocalRepository());
    viewModel = LoginViewModel(loginUseCase);
    loginView = MockLoginView();
    viewModel.view = loginView;
  });

  tearDown(() {
    get.reset();
  });

  void mockSuccess() {
    final user = getMockUser();
    when(repository.login(viewModel.model)).thenAnswer(
      (_) async => Result.success(user),
    );
  }

  test("should call onLoginSuccess when login information is everything ok", () async {
    // arrange
    mockSuccess();
    viewModel.model.login = "a@a.com";
    viewModel.model.password = "123";

    // act
    await viewModel.login();

    // assert
    verify(loginView.onLoginSuccess());
  });

  test("should validate required fields", () async {
    // arrange
    viewModel.model.login = "";
    viewModel.model.password = "";

    // act
    await viewModel.login();

    // assert
    expect(viewModel.validator.login$.stream, emits(R.strings.loginRequired));
    expect(viewModel.validator.password$.stream, emits(R.strings.passwordRequired));

    verifyNever(loginView.onLoginSuccess());
  });

  test("should validate that password must have at least 3 numbers", () async {
    // arrange
    viewModel.model.login = "user";
    viewModel.model.password = "12";

    // act
    await viewModel.login();

    // assert
    viewModel.close();

    expect(viewModel.validator.login$.stream, emits(null));
    expect(viewModel.validator.password$.stream, emits(R.strings.passwordMinLength));
    verifyNever(loginView.onLoginSuccess());
  });
}
