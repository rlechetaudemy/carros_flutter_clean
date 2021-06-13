import 'package:app/imports.dart';
import 'package:app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    initGetIt(env: Env.mock);
  });

  tearDown((){
    get.reset();
  });

  Future<void> openDrawer(WidgetTester tester) async {
    final userHeader = find.byType(UserAccountsDrawerHeader);
    // open
    scaffoldKey.currentState?.openDrawer();
    await tester.pump(); // start animation
    await tester.pump(const Duration(seconds: 1)); // animation done
    expect(userHeader, findsOneWidget);
  }

  testWidgets('login with success', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('App - Login'), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Password'), findsOneWidget);

    var btLogin = find.byType(AppButton);
    var loading = find.byType(CircularProgressIndicator);
    var back  = find.byTooltip('Back');

    expect(btLogin, findsOneWidget);
    expect(loading, findsNothing);

    // Validate required fields
    await tester.tap(find.byType(AppButton));
    await tester.pumpAndSettle();
    expect(find.text("Login is required"), findsOneWidget);
    expect(find.text("Password is required"), findsOneWidget);

    // Type login/password
    await tester.enterText(find.byType(TextFormField).first, "user");
    await tester.enterText(find.byType(TextFormField).last, "123");
    await tester.pumpAndSettle();

    // Login
    await tester.tap(find.byType(AppButton));
    await tester.pumpAndSettle();

    // Cars
    expect(find.byType(CarsPage), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text("Tucker 1948"), findsOneWidget);
    expect(find.text("Chevrolet Corvette"), findsOneWidget);

    // Click Car
    final car = find.byKey(Key("list_item_0"));
    await tester.tap(car);
    await tester.pumpAndSettle();

    // Cars by Id
    expect(find.byType(CarByIdPage), findsOneWidget);
    expect(find.text("Tucker 1948"), findsNWidgets(2));

    // Back > Cars
    await tester.tap(back);
    await tester.pumpAndSettle();
    expect(find.byType(CarsPage), findsOneWidget);

    // Logout
    await openDrawer(tester);
    await tester.tap(find.text("Logout"));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('login with success 2', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('App - Login'), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Password'), findsOneWidget);

    var btLogin = find.byType(AppButton);
    var loading = find.byType(CircularProgressIndicator);
    var back  = find.byTooltip('Back');

    expect(btLogin, findsOneWidget);
    expect(loading, findsNothing);

    // Validate required fields
    await tester.tap(find.byType(AppButton));
    await tester.pumpAndSettle();
    expect(find.text("Login is required"), findsOneWidget);
    expect(find.text("Password is required"), findsOneWidget);

    // Type login/password
    await tester.enterText(find.byType(TextFormField).first, "user");
    await tester.enterText(find.byType(TextFormField).last, "123");
    await tester.pumpAndSettle();

    // Login
    await tester.tap(find.byType(AppButton));
    await tester.pumpAndSettle();

    // Cars
    expect(find.byType(CarsPage), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text("Tucker 1948"), findsOneWidget);
    expect(find.text("Chevrolet Corvette"), findsOneWidget);

    // Click Car
    final car = find.byKey(Key("list_item_1"));
    await tester.tap(car);
    await tester.pumpAndSettle();

    // Cars by Id
    expect(find.byType(CarByIdPage), findsOneWidget);
    expect(find.text("Chevrolet Corvette"), findsNWidgets(2));

    // Back > Cars
    await tester.tap(back);
    await tester.pumpAndSettle();
    expect(find.byType(CarsPage), findsOneWidget);

    // Logout
    await openDrawer(tester);
    await tester.tap(find.text("Logout"));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });
}