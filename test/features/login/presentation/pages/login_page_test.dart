import '../../../../test_imports.dart';

void main() {
  late LoginViewModel viewModel;
  late LoginView loginView;
  late RouteManager routeManager;

  setUp(() {
    initGetItTest();

    viewModel = MockLoginViewModel();
    loginView = MockLoginView();
    viewModel.view = loginView;
    get.registerFactory<LoginViewModel>(() => viewModel);

    when(viewModel.loading$).thenReturn(BooleanStream());
    when(viewModel.tLogin).thenReturn(TextEditingController());
    when(viewModel.tSenha).thenReturn(TextEditingController());

    final validator = LoginValidator();
    when(viewModel.validator).thenReturn(validator);

    routeManager = get<RouteManager>();
  });

  tearDown(() {
    get.reset();
  });

  testWidgets('should show initial login page', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    expect(find.text('App - Login'), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Password'), findsOneWidget);

    expect(find.byType(AppButton), findsOneWidget);
  });

  testWidgets('should show error message for validator streams', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    viewModel.validator.login$.add("Login is required");
    viewModel.validator.password$.add("Password is required");

    await tester.pumpAndSettle();

    expect(find.text("Login is required"), findsOneWidget);
    expect(find.text("Password is required"), findsOneWidget);
  });

  testWidgets('should show loading correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    var loading = find.byType(CircularProgressIndicator);

    expect(loading, findsNothing);

    viewModel.loading$.add(true);
    await tester.pump();
    expect(loading, findsOneWidget);

    viewModel.loading$.add(false);
    await tester.pump();
    expect(loading, findsNothing);
  });

  testWidgets('should call viewModel.login', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    await typeLoginAndPassword(tester);
    await tester.tap(find.byType(AppButton));

    verify(viewModel.setLogin("admin@admin.com"));
    verify(viewModel.setPassword("456789"));
    verify(viewModel.login());
  });

  testWidgets('should call viewModel.fake', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    await typeLoginAndPassword(tester);
    await tester.tap(find.byKey(Key('btnFake')));

    verify(viewModel.fake());
  });

  testWidgets('should go to /cars route when onLoginSuccess() is called',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    LoginPage.loginKey.currentState?.onLoginSuccess();

    expect(routeManager.lastPath, "/cars");
  });

  testWidgets('should show alert when onLoginError(msg) is called', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    String errorMsg = 'Error';

    expect(find.text(errorMsg), findsNothing);

    LoginPage.loginKey.currentState?.onLoginError(errorMsg);

    await tester.pump();
    expect(find.text(errorMsg), findsOneWidget);

    expect(routeManager.lastPath, isNull);
  });

  testWidgets('Should call close', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(LoginPage()));

    addTearDown(() {
      verify(viewModel.close()).called(1);
    });
  });
}

Future typeLoginAndPassword(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).first, "admin@admin.com");
  await tester.enterText(find.byType(TextFormField).last, "456789");
  await tester.pumpAndSettle();
}
