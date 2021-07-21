import '../../../../test_imports.dart';

void main() {
  late CarsViewModel viewModel;
  late ViewState<List<Car>> state;
  late RouteManager routeManager;

  setUp(() {
    initGetItTest();

    viewModel = MockCarsViewModel();
    state = ViewState<List<Car>>();
    when(viewModel.state).thenReturn(state);

    get.registerFactory<CarsViewModel>(() => viewModel);

    routeManager = get<RouteManager>();
  });

  tearDown(() {
    get.reset();
  });

  _mockGetCars(Future<List<Car>> future) {
    when(viewModel.fetch()).thenAnswer((_) async => future);
  }

  testWidgets('should show ListView when getting data succeed', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(CarsPage()));

    verify(viewModel.fetch());

    // app bar
    expect(find.text(R.strings.cars), findsOneWidget);

    final loading = find.byType(CircularProgressIndicator);
    final listView = find.byType(ListView);

    // Loading
    state.loading = true;
    await tester.pump();
    expect(loading, findsOneWidget);

    // ListView
    state.value = await getMockCars();
    await tester.pumpAndSettle();
    expect(loading, findsNothing);
    expect(listView, findsOneWidget);

    // Item Details
    expect(find.text("Tucker 1948"), findsOneWidget);
    expect(find.text("Chevrolet Corvette"), findsOneWidget);

    // Tap Car
    final car = find.byKey(Key("list_item_1"));
    await tester.tap(car);
    expect(routeManager.lastPath, "/cars/12251");
  });

  testWidgets('should call fetch again on pull to refresh', (WidgetTester tester) async {
    _mockGetCars(Future.value(getMockCars()));

    await tester.pumpWidget(MyAppTest(CarsPage()));

    verify(viewModel.fetch());

    // ListView
    state.value = await getMockCars();
    final listView = find.byType(ListView);
    await tester.pump();
    expect(listView, findsOneWidget);

    // Pull To Refresh
    await tester.fling(find.text("Tucker 1948"), const Offset(0.0, 300.0), 1000.0);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the scroll animation
    await tester.pump(const Duration(seconds: 1)); // finish the indicator settle animation
    await tester.pump(const Duration(seconds: 1)); // finish the indicator hide animation

    verify(viewModel.fetch()).called(1);
  });

  testWidgets('should show empty message when the cars list is empty',
      (WidgetTester tester) async {
    // load page
    await tester.pumpWidget(MyAppTest(CarsPage()));

    verify(viewModel.fetch());

    final loading = find.byType(CircularProgressIndicator);

    state.loading = true;
    await tester.pump();
    expect(loading, findsOneWidget);

    state.value = List<Car>.empty();
    await tester.pumpAndSettle();
    expect(loading, findsNothing);

    // assert
    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text(R.strings.cars_list_is_empty), findsOneWidget);
  });

  testWidgets('should show error on fail', (WidgetTester tester) async {
    // load page
    await tester.pumpWidget(MyAppTest(CarsPage()));

    verify(viewModel.fetch());

    // act
    expect(find.text(R.strings.cars), findsOneWidget);

    final loading = find.byType(CircularProgressIndicator);

    // Loading
    state.loading = true;
    await tester.pump();
    expect(loading, findsOneWidget);

    // Error
    state.error = ErrorState.create("Error.");
    await tester.pumpAndSettle();
    expect(loading, findsNothing);
    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text("Error."), findsOneWidget);
  });

  testWidgets('Should call close', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppTest(CarsPage()));

    addTearDown(() {
      verify(viewModel.close()).called(1);
    });
  });
}
