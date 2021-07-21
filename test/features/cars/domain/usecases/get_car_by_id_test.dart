import '../../../../test_imports.dart';

void main() {
  initGetItTest();

  late CarRepository repository;
  late GetCarById getCarById;

  setUp(() {
    repository = MockCarRepository();
    getCarById = GetCarById(repository);
  });

  test("should get Car by id", () async {
    // arrange
    Car car = getMockCar();
    when(repository.getCarById(1)).thenAnswer((_) async => Result.success(car));

    // act
    Result result = await getCarById(1);

    // assert
    expect(result.data, car);
  });
}
