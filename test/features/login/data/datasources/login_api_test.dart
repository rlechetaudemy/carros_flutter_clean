import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart' as matcher;

import '../../../../test_imports.dart';

void main() {
  late LoginApi dataSource;
  late MockClient httpClient;

  final String login = "a@a.com";
  final String pwd = "123";

  setUp(() {
    httpClient = MockClient();
    dataSource = LoginApiImpl(httpClient);
  });

  void mockHttp(String response, int statusCode) {
    when(httpClient.post(Uri.parse(LoginApi.URL),
            body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(response, statusCode));
  }

  test("should call http.post with correct values", () async {
      // arrange
      mockHttp(fixture('login.json'), 200);

      // act
      await dataSource.login(login, pwd);

      // assert
      verify(httpClient.post(
        Uri.parse(LoginApi.URL),
        body: jsonEncode({"username": login, "password": pwd}),
        headers: {'Content-Type': 'application/json'},
      ));
    },
  );

  test(
    'should return User when the response code is 200 (success)',
    () async {

      // arrange
      final user = getMockUser();
      mockHttp(fixture('login.json'), 200);

      // act
      final result = await dataSource.login(login, pwd);

      // assert
      expect(result, user);
    },
  );

  test(
    'should throw a ApiMessageException when the response code is 401 (Unauthorized)',
    () async {
      // arrange
      mockHttp(fixture('login_401.json'), 401);

      // act
      final call = dataSource.login;

      // assert
      expect(() => call(login, pwd), throwsA(matcher.TypeMatcher<ApiMessageException>()));
    },
  );

  test(
    'should throw a ApiException when the response code is 500 or other',
    () async {
      // arrange
      mockHttp("error", 500);

      // act
      final call = dataSource.login;

      // assert
      expect(() => call(login, pwd), throwsA(matcher.TypeMatcher<ApiException>()));
    },
  );
}
