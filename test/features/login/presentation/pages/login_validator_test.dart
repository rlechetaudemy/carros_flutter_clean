import '../../../../test_imports.dart';

void main() {
  late LoginValidator validator;
  late LoginModel model;

  setUp(() {
    initGetItTest();

    validator = LoginValidator();
    model = LoginModel();
  });

  tearDown(() {
    get.reset();

    validator.close();
  });

  test("Validate form is valid", () async {
    model.login = "user@a.com";
    model.password = "123";

    validator.validate(model);

    validator.close();

    expectLater(validator.login$.stream, emits(null));
    expectLater(validator.password$.stream, emits(null));
  });

  test("Validate required fields - with null values", () async {
    model.login = "";
    model.password = "";

    validator.validate(model);

    expect(validator.login$.stream, emits(R.strings.loginRequired));
    expect(validator.password$.stream, emits(R.strings.passwordRequired));
  });

  test("Validate required fields - with empty values", () async {
    model.login = "";
    model.password = "";

    validator.validate(model);

    expect(validator.login$.stream, emits(R.strings.loginRequired));
    expect(validator.password$.stream, emits(R.strings.passwordRequired));
  });

  test("Validate Password must have at least 3 numbers", () async {
    model.login = "abc";
    model.password = "12";

    validator.validate(model);
    validator.close();

    expect(validator.login$.stream, emits(null));
    expect(validator.password$.stream, emits(R.strings.passwordMinLength));
  });
}
