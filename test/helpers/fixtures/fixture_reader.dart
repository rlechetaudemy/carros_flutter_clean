import 'dart:io';

///https://stackoverflow.com/questions/45780255/flutter-how-to-load-file-for-testing
String mockFile(String name) {
  String path = 'test/helpers/fixtures/$name';
  try {
    return File(path).readAsStringSync();
  } catch (e) {
    return File("../$path").readAsStringSync();
  }
}
