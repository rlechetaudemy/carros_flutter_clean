import 'package:app/imports.dart';
import 'package:flutter_test/flutter_test.dart';

main() {

  test("Failure toString Test", () async {
    var f = GenericFailure();
    expect(f, isA<Failure>());
    expect(f.toString(), "GenericFailure Exception");
  });

  test("MessageFailure Test", () async {
    var f = MessageFailure("Some Error");
    expect(f, isA<Failure>());
    expect(f.toString(), "MessageFailure Exception");
    expect("Some Error", f.msg);
  });
}