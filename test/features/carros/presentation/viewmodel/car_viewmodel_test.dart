import '../../../../test_imports.dart';

void main() {
  late CarViewModel viewModel;
  late MockGetCarById getCarById;
  late NetworkManager networkManager;

  setUp(() {
    initGetItTest();

    getCarById = MockGetCarById();
    viewModel = CarViewModel(getCarById);

    networkManager = get<NetworkManager>();
  });

  tearDown(() {
    get.reset();
  });

  mockSuccess(Car car) {
    when(getCarById(1)).thenAnswer((_) async => Result.success(car));
  }

  mockFailure(Failure f) {
    when(getCarById(1)).thenAnswer((_) async => Result.failure(f));
  }

  test("should return car by id", () async {
    // arrange
    Car car = getMockCar();
    mockSuccess(car);

    // act
    await viewModel.fetch(1);

    // assert
    expect(viewModel.state.value, car);
  });

  test('should show loading correctly', () async {
    // arrange
    Car car = getMockCar();
    mockSuccess(car);

    // act
    await viewModel.fetch(1);

    // assert
    final v1 = ViewState<Car>.loading(true);
    final v2 = ViewState<Car>.value(car);
    expectLater(viewModel.state.stream, emitsInOrder([v1, v2]));
  });

  test("should return error when use case fails", () async {
    // arrange
    mockFailure(ApiFailure());

    // act
    await viewModel.fetch(1);

    // assert
    expect(viewModel.state.error?.msg, R.strings.msgApiFailure);
  });

  testWidgets('should show error when there is not network', (WidgetTester tester) async {
    // arrange (mock no internet)
    when(networkManager.isOffline()).thenAnswer((_) async => true);

    // act
    await viewModel.fetch(1);

    // assert
    expect(viewModel.state.error?.msg, R.strings.msgNoInternet);
  });

}
