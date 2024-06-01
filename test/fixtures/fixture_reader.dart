import 'dart:convert';
import 'dart:io';

String fixtureReader(String name) {
  return File('test/fixtures/$name').readAsStringSync();
}

Map<String, dynamic> fixtureReaderMap(String name) {
  final jsonString = File('test/fixtures/$name').readAsStringSync();
  return jsonDecode(jsonString) as Map<String, dynamic>;
}
