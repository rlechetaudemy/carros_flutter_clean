import '../../../../test_imports.dart';

void main() {
  setUp(() {
    initGetItTest();
  });

  tearDown(() {});

  testWidgets('should show page with correct values', (WidgetTester tester) async {
    Car car = getMockCar();

    await tester.pumpWidget(MyAppTest(CarPage(car)));

    expect(find.text("Tucker 1948"), findsNWidgets(2));

    expect(find.byType(CarWidget), findsOneWidget);
  });
}
