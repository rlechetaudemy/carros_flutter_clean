import '../../../../test_imports.dart';

void main() {
  late LoginModel model;
  late LoginRepository repository;
  late LoginApi api;

  setUp(() {
    initGetItTest();

    model = LoginModel();
    api = new MockLoginApi();
    repository = LoginRepositoryImpl(api);
  });

  tearDown(() {
    get.reset();
  });

  mockSuccess(User user) {
    model.login = "a@a.com";
    model.password = "123";

    when(api.login(model.login, model.password)).thenAnswer((_) async => user);
  }

  mockFailure(Exception exception) {
    model.login = "a@a.com";
    model.password = "123";

    when(api.login(model.login, model.password)).thenThrow(exception);
  }

  test("should return User when login is successful", () async {
    // arrange
    final user = getMockUser();
    mockSuccess(user);

    // act
    final result = await repository.login(model);

    // assert
    expect(result.data, user);
  });

  test("should return MessageFailure when login is incorrect", () async {
    // arrange
    mockFailure(ApiMessageException(msg: 'Login Error', statusCode: 401));

    // act
    final result = await repository.login(model);

    // assert
    expect(result.error, isA<MessageFailure>());
    final failure = result.error as MessageFailure;
    expect(failure.msg, 'Login Error');
  });

  test(
    'should return Failure when the api throws exception',
    () async {

      // arrange
      mockFailure(ApiException(statusCode: 500));

      // act
      final result = await repository.login(model);

      // assert
      expect(result.error, isA<ApiFailure>());
    },
  );
}
