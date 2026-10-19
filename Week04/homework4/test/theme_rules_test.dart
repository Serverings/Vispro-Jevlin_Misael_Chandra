// Guards the checklist: no hard-coded colours, font sizes or spacing numbers
// in feature code. All of those live in lib/core/theme/.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<File> files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.replaceAll('\\', '/').contains('core/theme/'))
      .toList();

  void expectNone(String name, RegExp pattern) {
    test(name, () {
      final List<String> hits = [];
      for (final File file in files) {
        final List<String> lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          final String line = lines[i].trim();
          if (line.startsWith('//')) continue;
          if (pattern.hasMatch(line)) hits.add('${file.path}:${i + 1}  $line');
        }
      }
      expect(hits, isEmpty, reason: hits.join('\n'));
    });
  }

  group('Theme rules', () {
    expectNone(
      'no hard-coded colours in feature code',
      RegExp(r'Color\(0x|\bColors\.'),
    );
    expectNone(
      'no hard-coded font sizes in feature code',
      RegExp(r'fontSize\s*:'),
    );
    expectNone(
      'no raw spacing numbers in feature code',
      RegExp(r'SizedBox\((height|width):\s*\d|EdgeInsets\.(all|symmetric)\(\s*\d'),
    );
  });
}