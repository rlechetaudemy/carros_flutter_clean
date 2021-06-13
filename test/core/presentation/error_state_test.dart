import '../../test_imports.dart';

class TestFailure extends Failure {}

main() {
  test('should return correct messages - General', () {
    expect(ErrorState.noInternet().msg, R.strings.msgNoInternet);

    expect(ErrorState.create(null).msg, R.strings.msgGenericError);

    expect(ErrorState.create("error").msg, "error");

    expect(ErrorState.create(123).msg, R.strings.msgGenericError);
  });

  test('should return correct messages for Exceptions', () {

    expect(ErrorState.create(ApiMessageException(statusCode: 200, msg: "Error")).msg, "Error");

    expect(ErrorState.create(TimeoutException("")).msg, R.strings.msgTimeoutException);

    expect(ErrorState.create(SocketException("")).msg, R.strings.msgTimeoutException);
  });

  test('should return correct messages for Failures', () {

    expect(ErrorState.create(ApiFailure()).msg, R.strings.msgApiFailure);

    expect(ErrorState.create(MessageFailure("Error")).msg, "Error");

    expect(ErrorState.create(TestFailure()).msg, R.strings.msgGenericError);
  });

  test('equals test', () {
    var error1 = ErrorState.noInternet();
    var error2 = ErrorState.noInternet();

    expect(error1, error2);
  });
}
