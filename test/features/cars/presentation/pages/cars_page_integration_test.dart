import '../../../../test_imports.dart';

void main() {
  late CarsViewModel viewModel;
  late GetCars getCars;
  late RouteManager routeManager;
  late NetworkManager networkManager;

  setUp(() {
    initGetItTest();

    getCars = MockGetCars();
    viewModel = CarsViewModel(getCars);
    get.registerFactory(() => viewModel);

    routeManager = get<RouteManager>();

    networkManager = get<NetworkManager>();
  });

  tearDown(() {
    get.reset();
  });

  mockSuccess(List<Car> cars) {
    when(getCars()).thenAnswer((_) => Future.value(Result.success(cars)));
  }

  mockFailure(Failure failure) {
    when(getCars()).thenAnswer((_) => Future.value(Result.failure(failure)));
  }

  testWidgets('should show ListView when getting data succeed', (WidgetTester tester) async {
    // arrange
    mockSuccess(getMockCars());

    await tester.pumpWidget(MyAppTest(CarsPage()));

    // app bar
    expect(find.text(R.strings.cars), findsOneWidget);

    final loading = find.byType(CircularProgressIndicator);
    final listView = find.byType(ListView);

    // Loading
    expect(loading, findsOneWidget);
    await tester.pump();

    // ListView
    expect(loading, findsNothing);
    expect(listView, findsOneWidget);

    expect(find.text("Chevrolet Corvette"), findsOneWidget);
    expect(find.text("Tucker 1948"), findsOneWidget);
  });

  testWidgets('should navigate to details page when taps in the list item',
      (WidgetTester tester) async {
    mockSuccess(getMockCars());

    await tester.pumpWidget(MyAppTest(CarsPage()));

    // ListView
    final listView = find.byType(ListView);
    await tester.pump();
    expect(listView, findsOneWidget);

    // tap Car
    final chevroletCorvette = find.byKey(Key("list_item_1"));
    await tester.tap(chevroletCorvette);
    await tester.pump();

    // Route details ok
    await tester.pumpAndSettle();
    expect(routeManager.lastPath, "/cars/12251");
  });

  testWidgets('should show message when the list is empty', (WidgetTester tester) async {
    // arrange
    mockSuccess(List<Car>.empty());

    // load page
    await tester.pumpWidget(MyAppTest(CarsPage()));

    // loading
    final loading = find.byType(CircularProgressIndicator);
    final listView = find.byType(ListView);
    expect(loading, findsOneWidget);
    await tester.pump();

    // assert
    expect(loading, findsNothing);
    expect(listView, findsNothing);
    expect(find.text(R.strings.cars_list_is_empty), findsOneWidget);
  });

  testWidgets('should show error on fail', (WidgetTester tester) async {
    mockFailure(ApiFailure());

    // load page
    await tester.pumpWidget(MyAppTest(CarsPage()));

    // loading
    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsOneWidget);
    await tester.pump();

    // Error
    expect(loading, findsNothing);
    expect(find.text(R.strings.msgApiFailure),findsOneWidget);
    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('should show error when there is not network', (WidgetTester tester) async {
    mockSuccess(List<Car>.empty());

    when(networkManager.isOffline()).thenAnswer((_) async => true);

    await tester.pumpWidget(MyAppTest(CarsPage()));

    // loading
    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsOneWidget);
    await tester.pump();

    // Error
    expect(loading, findsNothing);
    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text(R.strings.msgNoInternet), findsOneWidget);
  });

  testWidgets('should refresh data when click in the refresh button', (WidgetTester tester) async {
    // arrange (error)
    mockFailure(ApiFailure());

    await tester.pumpWidget(MyAppTest(CarsPage()));

    final listView = find.byType(ListView);

    // Error
    await tester.pump();
    expect(find.text(R.strings.msgApiFailure),findsOneWidget);
    expect(find.byType(ErrorView), findsOneWidget);
    expect(listView, findsNothing);

    // try again with a nice mock :-)
    mockSuccess(getMockCars());

    // Pull To Refresh
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    // ListView
    expect(listView, findsOneWidget);
    expect(find.byType(ErrorView), findsNothing);
  });
}
