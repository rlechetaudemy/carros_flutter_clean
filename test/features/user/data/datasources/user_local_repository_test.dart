import '../../../../test_imports.dart';

main(){
  late UserLocalRepository repository;
  late Prefs prefs;
  late AppState appState;

  setUp((){
    initGetItTest();

    prefs = MockPrefs();
    appState = get<AppState>();
    repository = UserLocalRepositoryImpl(prefs, appState);
  });

  tearDown((){
    get.reset();
  });

  test("should save user", () async {
    // arrange
    User user = getMockUser();

    // act
    await repository.save(user);

    // assert
    verify(prefs.setString("user.prefs", user.toJson()));
    expect(appState.user, user);
  });

  test("should clear all user data", () async {
    // arrange
    User user = getMockUser();
    appState.user = user;

    // act
    await repository.clear();

    // assert
    verify(prefs.setString("user.prefs", ""));
    expect(appState.user, isNull);
  });
}