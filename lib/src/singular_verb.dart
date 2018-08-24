library inflection.singular_verb;

import 'dart:convert';

import 'irregular_plural_verbs.dart';
import 'util.dart';

class SingularVerbEncoder extends Converter<String, String> {
  final List<List> _inflectionRules = [];

  SingularVerbEncoder() {
    irregularPluralVerbs.forEach((singular, plural) {
      addInflectionRule(plural, (m) => singular);
    });

    [
      [r'$', (m) => 's'],
      [r'([^aeiou])y$', (m) => '${m[1]}ies'],
      [r'(z)$', (m) => '${m[1]}es'],
      [r'(ss|zz|x|h|o|us)$', (m) => '${m[1]}es'],
      [r'(ed)$', (m) => '${m[1]}']
    ]
        .reversed
        .forEach((rule) => addInflectionRule(rule.first as String, rule.last));
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
          return word.replaceAllMapped(pattern, r.last as MatchToString);
        }
      }
    }

    return word;
  }
}

final Converter<String, String> SINGULARVERB = new SingularVerbEncoder();
