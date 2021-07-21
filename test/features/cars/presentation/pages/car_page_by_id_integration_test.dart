import '../../../../test_imports.dart';

void main() {
  late CarViewModel viewModel;
  late GetCarById getCarById;

  setUp(() {
    initGetItTest();

    getCarById = MockGetCarById();
    viewModel = CarViewModel(getCarById);
    get.registerFactory<CarViewModel>(() => viewModel);
  });

  tearDown(() {
    get.reset();
  });

  void mockSuccess() {
    Car car = getMockCar();
    when(getCarById(1)).thenAnswer((_) => Future.delayed(mock_delay,() => Result.success(car)));
  }

  void mockFailure() {
    when(getCarById(1)).thenAnswer((_) => Future.delayed(mock_delay,() => Result.failure(ApiFailure())));
  }

  testWidgets('should show CarWidget when getting data succeed', (WidgetTester tester) async {
    // arrange
    mockSuccess();

    // Load Page
    Car car = getMockCar();
    int carId = car.id;
    await tester.pumpWidget(MyAppTest(CarByIdPage(carId)));

    // Loading
    final loading = find.byType(CircularProgressIndicator);
    await tester.pump();
    expect(loading, findsOneWidget);
    await tester.pump(mock_delay);
    expect(loading, findsNothing);

    // CarWidget
    expect(find.text("Tucker 1948"), findsNWidgets(2));
    expect(find.byType(CarWidget), findsOneWidget);

    // No Error
    expect(find.byType(ErrorView), findsNothing);
  });

  testWidgets('should show ErrorView when getting data fails', (WidgetTester tester) async {
    // arrange
    mockFailure();

    // Load Page
    Car car = getMockCar();
    int carId = car.id;
    await tester.pumpWidget(MyAppTest(CarByIdPage(carId)));

    // Loading
    final loading = find.byType(CircularProgressIndicator);
    await tester.pump();
    expect(loading, findsOneWidget);
    await tester.pump(mock_delay);
    expect(loading, findsNothing);

    // CarWidget - not found
    expect(find.byType(CarWidget), findsNothing);

    // Error
    expect(find.text(R.strings.msgApiFailure), findsOneWidget);
    expect(find.byType(ErrorView), findsOneWidget);
  });
}
