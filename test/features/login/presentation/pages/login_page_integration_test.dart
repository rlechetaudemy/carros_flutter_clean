import '../../../../test_imports.dart';

void main() {
  late LoginViewModel viewModel;
  late LoginUseCase loginUseCase;
  late RouteManager routeManager;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    initGetItTest();

    loginUseCase = MockLoginUseCase();
    viewModel = LoginViewModel(loginUseCase);
    get.registerFactory(() => viewModel);

    routeManager = get<RouteManager>();
  });

  tearDown(() {
    get.reset();
  });

  void mockLoginSuccess() {
    when(loginUseCase(viewModel.model)).thenAnswer(
      (_) => Future.delayed(mock_delay, () => Result.success(getMockUser())),
    );
  }

  void mockLoginError(String msg) {
    when(loginUseCase(viewModel.model))
        .thenAnswer((_) async => Result.failure(MessageFailure("Login Error")));
  }

  testWidgets('should validate required fields', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    await tester.tap(find.byType(AppButton));
    await tester.pumpAndSettle();

    expect(find.text(R.strings.loginRequired), findsOneWidget);
    expect(find.text(R.strings.passwordRequired), findsOneWidget);

    // fix form
    await typeLoginAndPassword(tester);
    await tester.pumpAndSettle();

    expect(find.text(R.strings.loginRequired), findsNothing);
    expect(find.text(R.strings.passwordRequired), findsNothing);
  });

  testWidgets('should show loading correctly', (WidgetTester tester) async {
    mockLoginSuccess();

    await tester.pumpWidget(MyAppTest(LoginPage()));

    await typeLoginAndPassword(tester);

    // loading
    var loading = find.byType(CircularProgressIndicator);
    expect(loading, findsNothing);

    // tap
    await tester.tap(find.byType(AppButton));
    await tester.pump();

    // show loading
    expect(loading, findsOneWidget);

    await tester.pump(mock_delay);

    // not loading
    expect(loading, findsNothing);

    expect(viewModel.loading$.stream, emitsInOrder([true, false]));
  });

  testWidgets('should go to /cars route when login is successful', (WidgetTester tester) async {
    mockLoginSuccess();

    await tester.pumpWidget(MyAppTest(LoginPage()));

    await typeLoginAndPassword(tester);

    await tester.tap(find.byType(AppButton));
    await tester.pump(mock_delay);

    // navigation ok
    expect(routeManager.lastPath, "/cars");
  });

  testWidgets('should show alert when login fails', (WidgetTester tester) async {
    mockLoginError("Erro de login");

    await tester.pumpWidget(MyAppTest(LoginPage()));

    await typeLoginAndPassword(tester);

    await tester.tap(find.byType(AppButton));
    await tester.pump(mock_delay);

    // alert
    expect(find.text("Login Error"), findsOneWidget);

    expect(routeManager.lastPath, isNull);
  });

  testWidgets('should display fake data', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    await typeLoginAndPassword(tester);
    await tester.tap(find.byKey(Key('btnFake')));

    expect(find.text("user"), findsOneWidget);
    expect(find.text("123"), findsOneWidget);
  });
}

Future typeLoginAndPassword(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).first, "admin@admin.com");
  await tester.enterText(find.byType(TextFormField).last, "456789");
  await tester.pumpAndSettle();
}
