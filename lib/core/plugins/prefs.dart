import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Prefs {
  Future<String> getString(String key);

  Future<void> setString(String key, String s);
}

class SecureStoragePrefs implements Prefs {
  FlutterSecureStorage storage;

  SecureStoragePrefs(this.storage);

  Future<String> getString(String key) async {
    String? value = await storage.read(key: key);
    return value ?? "";
  }

  Future<void> setString(String key, String s) async {
    storage.write(key: key, value: s);
  }
}
