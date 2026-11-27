import 'dart:io';

class FixtureReader {
  const FixtureReader();

  String read(String name) => File('test/fixtures/$name').readAsStringSync();
}
