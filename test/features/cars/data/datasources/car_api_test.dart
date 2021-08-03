import 'package:http/http.dart' as http;

import '../../../../test_imports.dart';

void main() {
  late CarApi api;
  late MockClient httpClient;

  setUp(() {
    httpClient = MockClient();
    api = CarApiImpl(httpClient);
  });

  void setUpHttp(String url, String body, int statusCode) {
    var uri = Uri.parse(url);
    when(httpClient.get(uri)).thenAnswer((_) async => http.Response(body, statusCode));
  }

  group("get cars list", () {
    test(
      'should return list of cars when the response code is 200 (success)',
      () async {
        // arrange
        setUpHttp(CarApi.URL, mockFile('cars.json'), 200);

        // act
        final result = await api.getCars();

        // assert
        expect(result, getMockCars());
      },
    );

    test(
      'should throw a ApiException when the response code is different than 200',
      () async {
        // arrange
        setUpHttp(CarApi.URL, "error", 500);

        // assert
        expect(() => api.getCars(), throwsA(TypeMatcher<ApiException>()));
      },
    );
  });

  group("get car", () {
    test(
      'should return car when the response code is 200 (success)',
      () async {

        // arrange
        Car car = getMockCar();

        String json = mockFile("car.json");
        String url = "${CarApi.URL}/1";
        setUpHttp(url, json, 200);

        // act
        Car result = await api.getCarById(1);

        // assert
        expect(result, car);
      },
    );

    test(
      'should throw a ApiException when the response code is different than 200',
      () async {
        // arrange
        String url = "${CarApi.URL}/1";
        setUpHttp(url, "error", 500);

        // assert
        expect(() => api.getCarById(1), throwsA(TypeMatcher<ApiException>()));
      },
    );
  });
}
