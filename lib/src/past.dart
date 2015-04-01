library inflection.past;

import 'dart:convert';

import 'irregular_past_verbs.dart';

class PastEncoder extends Converter<String, String> {
  final List<List> _inflectionRules = [];

  PastEncoder() {
    irregularPastVerbs.forEach((String presentOrParticiple, String past) {
      addIrregularInflectionRule(presentOrParticiple, past);
    });

    [
      [r'.+', (m) => '${m[0]}ed'],
      [r'([^aeiou])y$', (m) => '${m[1]}ied'],
      [r'([aeiou]e)$', (m) => '${m[1]}d'],
      [r'[aeiou][^aeiou]e$', (m) => '${m[0]}d']
    ].reversed.forEach((rule) => addInflectionRule(rule.first, rule.last));
  }

  void addInflectionRule(String presentOrParticiple, dynamic past) {
    _inflectionRules
        .add([new RegExp(presentOrParticiple, caseSensitive: false), past]);
  }

  void addIrregularInflectionRule(String presentOrParticiple, String past) {
    _inflectionRules.add([
      new RegExp(r'^(back|dis|for|fore|in|inter|mis|off|over|out|par|pre|re|type|un|under|up)?' + presentOrParticiple + r'$',
          caseSensitive: false),
      (m) => (m[1] == null) ? past : m[1] + past
    ]);
  }

  @override
  String convert(String word) {
    if (!word.isEmpty) {
      for (var r in _inflectionRules) {
        RegExp pattern = r.first;
        if (pattern.hasMatch(word)) {
          return word.replaceAllMapped(pattern, r.last);
        }
      }
    }

    return word;
  }
}

final Converter<String, String> PAST = new PastEncoder();
