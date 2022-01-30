import '../../../../test_imports.dart';

void main() {
  initGetItTest();

  late CarRepository repository;
  late GetCars getCars;

  setUp(() {
    repository = MockCarRepository();
    getCars = GetCars(repository);
  });

  test("should get list of Cars", () async {
    // arrange
    List<Car> cars = getMockCars();
    when(repository.getCars()).thenAnswer((_) async => Result.success(cars));

    // act
    Result result = await getCars();

    // assert
    expect(result.data, cars);
  });

  test("should convert Exception to Error", () async {
    // arrange
    var failure = ApiFailure();
    when(repository.getCars()).thenAnswer((_) async => Result.failure(failure));

    // act
    Result result = await getCars();

    // assert
    expect(result.isSuccess, false);
    expect(result.error, failure);
  });
}
