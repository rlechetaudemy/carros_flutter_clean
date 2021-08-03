import '../../../../test_imports.dart';

void main() {
  initGetItTest();

  late LoginRepository repository;
  late UserLocalRepository userLocalRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    repository = MockLoginRepository();
    userLocalRepository = MockUserLocalRepository();
    loginUseCase = LoginUseCaseImpl(repository, userLocalRepository);
  });

  test("should login", () async {
    // arrange
    final user = getMockUser();
    final model = LoginModel();
    when(repository.login(model)).thenAnswer((_) async => Result.success(user));

    // act
    final result = await loginUseCase(model);

    // assert
    expect(result.data, user);
    verify(userLocalRepository.save(user));
  });

  test("should return error", () async {
    // arrange
    final user = getMockUser();
    final model = LoginModel();
    when(repository.login(model)).thenAnswer((_) async => Result.failure(TimeoutFailure()));

    // act
    final result = await loginUseCase(model);

    // assert
    expect(result.isSuccess, false);
    expect(result.error, isA<TimeoutFailure>());
    verifyNever(userLocalRepository.save(user));
  });
}
