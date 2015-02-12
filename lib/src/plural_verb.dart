library inflection.plural.verb;

import 'dart:convert';

import 'irregular_plural_verbs.dart';

class PluralVerbEncoder extends Converter<String, String> {
  final List<List> _inflectionRules = [];

  PluralVerbEncoder() {
    irregularPluralVerbs.forEach((singular, plural) {
      addInflectionRule(singular, (m) => plural);
    });

    [
      [r'e?s$', (m) => ''],
      [r'ies$', (m) => 'y'],
      [r'([^h|z|o|i])es$', (m) => '${m[1]}e'],
      [r'ses$', (m) => 's'],
      [r'zzes$', (m) => 'zz'],
      [r'([cs])hes$', (m) => '${m[1]}h'],
      [r'xes$', (m) => 'x'],
      [r'sses$', (m) => 'ss']
    ].reversed.forEach((rule) => addInflectionRule(rule.first, rule.last));
  }

  void addInflectionRule(String singular, dynamic plural) {
    _inflectionRules.add([new RegExp(singular, caseSensitive: false), plural]);
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

final Converter<String, String> PLURALVERB = new PluralVerbEncoder();
