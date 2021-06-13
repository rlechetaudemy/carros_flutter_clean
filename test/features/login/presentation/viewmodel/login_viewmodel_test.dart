import '../../../../test_imports.dart';

void main() {
  late LoginViewModel viewModel;
  late LoginUseCase loginUseCase;
  late LoginView loginView;

  setUp(() {
    initGetItTest();

    loginUseCase = MockLoginUseCase();
    viewModel = LoginViewModel(loginUseCase);
    loginView = MockLoginView();
    viewModel.view = loginView;
  });

  tearDown(() {
    get.reset();
  });

  mockSuccess(User user) {
    viewModel.model.login = "user";
    viewModel.model.password = "123";

    when(loginUseCase(viewModel.model)).thenAnswer((_) async => Result.success(user));
  }

  mockFailure(Failure f) {
    viewModel.model.login = "user";
    viewModel.model.password = "123";

    when(loginUseCase(viewModel.model)).thenAnswer((_) async => Result.failure(f));
  }

  test("should call onLoginSuccess when login succeed", () async {

    // arrange
    final user = getMockUser();
    mockSuccess(user);

    // act
    await viewModel.login();

    // assert
    verify(loginView.onLoginSuccess());
    // TODO verifyNever
    expectLater(viewModel.loading$.stream, emitsInOrder([true, false]));
  });

  test("should call onLoginError when login fails", () async {

    // arrange
    mockFailure(ApiFailure());

    // act
    await viewModel.login();

    // assert
    verifyNever(loginView.onLoginSuccess());
    verify(loginView.onLoginError(R.strings.msgApiFailure));
    expectLater(viewModel.loading$.stream, emitsInOrder([true, false]));
  });

  test("should close stream correctly", () async {
    // arrange
    viewModel.loading$.add(true);

    expect(viewModel.loading$.stream, emits(true));

    // act - close stream
    viewModel.close();

    // assert
    expect(viewModel.loading$.isClosed, true);

    // Stop emitting...
    viewModel.loading$.add(false);
    expect(viewModel.loading$.stream, neverEmits(false));
  });
}
