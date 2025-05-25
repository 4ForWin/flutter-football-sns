import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('description', () {
    final map = jsonDecode(File('test/dummy/feed_dto.json').readAsStringSync());
    final list = List<int>.from(map['appicant']);
    print(list);
  });
}
