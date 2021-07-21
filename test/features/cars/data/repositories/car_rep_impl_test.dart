import '../../../../test_imports.dart';

void main() {
  late CarRepository repository;
  late CarApi api;

  setUp(() {
    initGetItTest();

    api = MockCarApi();
    repository = CarRepositoryImpl(api);
  });

  tearDown(() {
    get.reset();
  });

  group("get cars list", () {
    test("should return list of cars", () async {
      // arrange
      List<Car> cars = getMockCars();
      when(api.getCars()).thenAnswer((_) async => cars);

      // act
      Result result = await repository.getCars();

      // assert
      expect(result.data, cars);
    });

    test(
      'should return ApiFailure when the Api throws exception',
      () async {
        // arrange
        when(api.getCars()).thenThrow(ApiException(statusCode: 500));

        // act
        Result result = await repository.getCars();

        // assert
        expect(result.error, isA<ApiFailure>());
      },
    );

    test(
      'should return TimeoutFailure when the Api throws TimeoutException',
      () async {
        // arrange
        when(api.getCars()).thenThrow(TimeoutException(""));

        // act
        Result result = await repository.getCars();

        // assert
        expect(result.error, isA<TimeoutFailure>());
      },
    );
  });

  group("get car", () {
    test("should return the car by id", () async {
      // arrange
      Car car = getMockCar();
      when(api.getCarById(1)).thenAnswer((_) async => car);

      // act
      Result result = await repository.getCarById(1);

      // assert
      expect(result.data, car);
    });

    test(
      'should return ApiFailure when the Api throws exception',
      () async {
        // arrange
        when(api.getCarById(1)).thenThrow(ApiException(statusCode: 500));

        // act
        Result result = await repository.getCarById(1);

        // assert
        expect(result.error, isA<ApiFailure>());
      },
    );

    test(
      'should return TimeoutFailure when the Api throws TimeoutException',
      () async {
        // arrange
        when(api.getCarById(1)).thenThrow(TimeoutException(""));

        // act
        Result result = await repository.getCarById(1);

        // assert
        expect(result.error, isA<TimeoutFailure>());
      },
    );
  });
}
