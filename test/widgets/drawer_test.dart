import '../test_imports.dart';

late BuildContext savedContext;
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void main() {
  late RouteManager routeManager;

  late LogoutViewModel logoutViewModel;

  setUp(() {
    initGetItTest();

    logoutViewModel = MockLogoutViewModel();
    get.registerFactory<LogoutViewModel>(() => logoutViewModel);

    routeManager = get<RouteManager>();

    // navigation
    // get.registerFactory(() => LoginViewModel(MockLoginUseCase()));
  });

  tearDown(() {
    get.reset();
  });

  Future<void> openPage(WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(TestDrawerPage()));

    final userHeader = find.byType(UserAccountsDrawerHeader);

    await tester.pump();

    // drawer is closed
    expect(userHeader, findsNothing);
  }

  Future<void> openDrawer(WidgetTester tester) async {
    final userHeader = find.byType(UserAccountsDrawerHeader);
    // open
    scaffoldKey.currentState?.openDrawer();
    await tester.pump(); // start animation
    await tester.pump(const Duration(seconds: 1)); // animation done
    expect(userHeader, findsOneWidget);
  }

  Future<void> closeDrawer(WidgetTester tester) async {
    // close
    Navigator.pop(savedContext);

    await tester.pump(); // start animation
    await tester.pump(const Duration(seconds: 1)); // animation done
  }

  testWidgets('should open drawer with correct values', (WidgetTester tester) async {

    // arrange
    get<AppState>().user = getMockUser();
    await openPage(tester);

    // act
    await openDrawer(tester);

    // assert
    expect(find.text("Cars"), findsOneWidget);
    expect(find.text("Settings"), findsOneWidget);
    expect(find.text("Help"), findsOneWidget);
    expect(find.text("Logout"), findsOneWidget);

    // user
    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text("User A"), findsOneWidget);
    expect(find.text("a@a.com"), findsOneWidget);
  });

  testWidgets('should close drawer with success', (WidgetTester tester) async {
    // arrange
    get<AppState>().user = getMockUser();
    await openPage(tester);

    // act
    await openDrawer(tester);
    await closeDrawer(tester);

    // assert
    final userHeader = find.byType(UserAccountsDrawerHeader);
    expect(userHeader, findsNothing);
  });

  testWidgets('should close drawer when tap menu item', (WidgetTester tester) async {
    // arrange
    get<AppState>().user = getMockUser();
    await openPage(tester);

    // Tap Cars
    await openDrawer(tester);
    await tester.tap(find.text("Cars"));
    await verifyDrawerIsClosed(tester);

    // Tap Settings
    await openDrawer(tester);
    await tester.tap(find.text("Settings"));
    await verifyDrawerIsClosed(tester);

    // Tap Help
    await openDrawer(tester);
    await tester.tap(find.text("Help"));
    await verifyDrawerIsClosed(tester);
  });

testWidgets('should logout and redirect to the login page', (WidgetTester tester) async {
    // arrange
    get<AppState>().user = getMockUser();
    await openPage(tester);

    // act
    await openDrawer(tester);
    await tester.tap(find.text("Logout"));

    // assert
    await verifyDrawerIsClosed(tester);
    verify(logoutViewModel.logout()).called(1);
    expect(routeManager.lastPath, "/");
  });
}

Future verifyDrawerIsClosed(WidgetTester tester) async {
  await tester.pump(); // start animation
  await tester.pump(const Duration(seconds: 1)); // animation done
  final userHeader = find.byType(UserAccountsDrawerHeader);
  expect(userHeader, findsNothing);
}

class TestDrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        savedContext = context;
        return Scaffold(
          key: scaffoldKey,
          drawer: DrawerList(),
          body: Container(),
        );
      },
    );
  }
}
