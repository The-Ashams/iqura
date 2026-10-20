import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/core/app_info.dart';

void main() {
  test('appVersion correspond à pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(
      r'^version:\s*([^+\s]+)',
      multiLine: true,
    ).firstMatch(pubspec)![1];
    expect(appVersion, version);
  });
}
