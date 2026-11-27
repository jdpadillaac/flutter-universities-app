import 'dart:io';

/// Reads a file from `test/fixtures`.
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
