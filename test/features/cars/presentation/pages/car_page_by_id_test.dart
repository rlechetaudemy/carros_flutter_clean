import '../../../../test_imports.dart';

void main() {
  late CarViewModel viewModel;
  late ViewState<Car> state;

  setUp(() {
    initGetItTest();

    viewModel = MockCarViewModel();
    state = ViewState<Car>();
    when(viewModel.state).thenReturn(state);

    get.registerFactory<CarViewModel>(() => viewModel);
  });

  tearDown(() {
    get.reset();
  });

  testWidgets('should show the correct view state: loading/value/error', (WidgetTester tester) async {
    // act
    Car car = getMockCar();
    int carId = car.id;
    await tester.pumpWidget(MyAppTest(CarByIdPage(carId)));

    // assert
    verify(viewModel.fetch(carId));

    // Loading
    final loading = find.byType(CircularProgressIndicator);
    state.loading = true;
    await tester.pump();
    expect(loading, findsOneWidget);

    // CarWidget
    state.value = car;
    await tester.pump();
    expect(loading, findsNothing);
    expect(find.text("Tucker 1948"), findsNWidgets(2));
    expect(find.byType(CarWidget), findsOneWidget);

    // Error
    state.error = ErrorState.create('Test Error');
    await tester.pump();
    expect(find.text("Test Error"), findsOneWidget);
    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('Should call close', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(CarByIdPage(1)));

    addTearDown(() {
      verify(viewModel.close()).called(1);
    });
  });
}
