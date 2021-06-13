import '../../../../test_imports.dart';

void main() {
  late CarsViewModel viewModel;
  late MockGetCars getCars;

  setUp(() {
    initGetItTest();

    getCars = MockGetCars();
    viewModel = CarsViewModel(getCars);
  });

  tearDown(() {
    get.reset();
  });

  void mockSuccess(List<Car> cars) {
    when(getCars()).thenAnswer((_) async => Result.success(cars));
  }

  void mockFailure(Failure f) {
    when(getCars()).thenAnswer((_) async => Result.failure(f));
  }


  test("should return the cars list", () async {
    // arrange
    mockSuccess(getMockCars());

    // act
    await viewModel.fetch();

    // assert
    List<Car>? list = viewModel.state.value;
    expectLater("Tucker 1948", list?.first.name);
    expectLater("Lexus LFA", list?.last.name);
  });

  test("should return the cars list (empty test)", () async {
    // arrange
    mockSuccess([]);

    // act
    await viewModel.fetch();

    // assert
    List<Car>? list = viewModel.state.value;
    expect(list, isEmpty);
  });

  test('should show loading correctly', () async {
    // arrange
    List<Car> cars = getMockCars();
    mockSuccess(cars);

    // act
    await viewModel.fetch();

    // assert
    final v1 = ViewState<List<Car>>.loading(true);
    final v2 = ViewState<List<Car>>.value(cars);
    expectLater(viewModel.state.stream, emitsInOrder([v1, v2]));
  });

  test("should show error on fail", () async {
    // arrange
    mockFailure(ApiFailure());

    // act
    await viewModel.fetch();

    // assert
    expect(viewModel.state.value, isNull);
    expect(viewModel.state.error?.msg, R.strings.msgApiFailure);
  });
}