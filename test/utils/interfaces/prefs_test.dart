import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_imports.dart';

main(){
  late SecureStoragePrefs prefs;
  late FlutterSecureStorage storage;

  setUp((){
    storage = MockFlutterSecureStorage();
    prefs = SecureStoragePrefs(storage);
  });

  test("should call setString with correct values", () async {
    // act
    prefs.setString("msg", "Hello");

    // assert
    verify(storage.write(key: "msg", value: "Hello"));
  });

  test("should call getString with correct key", () async {
    // arrange
    when(storage.read(key: "msg")).thenAnswer((_) async => "Hello");
    when(storage.read(key: "msgEmpty")).thenAnswer((_) async => "");

    // act
    String s = await prefs.getString("msg");

    // assert
    verify(storage.read(key: "msg"));
    expect(s, "Hello");
  });

  test("getString should return empty string when there is no value ", () async {
    // arrange
    when(storage.read(key: "msg")).thenAnswer((_) async => "");

    // act
    String s = await prefs.getString("msg");

    // assert
    verify(storage.read(key: "msg"));
    expect(s, "");
  });
}