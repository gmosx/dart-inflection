library inflection.singular.verb;

import 'dart:convert';

import 'irregular_plural_verbs.dart';

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
//      [r'e?s$', (m) => ''],
//      [r'ies$', (m) => 'y'],
//      [r'([^h|z|o|i])es$', (m) => '${m[1]}e'],
//      [r'ses$', (m) => 's'],
//      [r'zzes$', (m) => 'zz'],
//      [r'([cs])hes$', (m) => '${m[1]}h'],
//      [r'xes$', (m) => 'x'],
//      [r'sses$', (m) => 'ss']
    ].reversed.forEach((rule) => addInflectionRule(rule.first, rule.last));
  }

  void addInflectionRule(String singular, dynamic plural) {
    _inflectionRules.add([new RegExp(singular, caseSensitive: false), plural]);
  }

//  void addIrregularInflectionRule(String singular, String plural) {
//    addInflectionRule(singular, plural);
//    final s0 = singular.substring(0, 1);
//    final srest = singular.substring(1);
//    final p0 = plural.substring(0, 1);
//    final prest = plural.substring(1);
//
//    if (s0.toUpperCase() == p0.toUpperCase()) {
//      addInflectionRule('(${s0})${srest}\$', (m) => '${m[1]}${prest}');
//      addInflectionRule('(${p0})${prest}\$', (m) => '${m[1]}${prest}');
//    } else {
//      addInflectionRule('${s0.toUpperCase()}(?i)${srest}\$', (m) => '${p0.toUpperCase()}${prest}');
//      addInflectionRule('${s0.toLowerCase()}(?i)${srest}\$', (m) => '${p0.toUpperCase()}${prest}');
//      addInflectionRule('${p0.toUpperCase()}(?i)${prest}\$', (m) => '${p0.toUpperCase()}${prest}');
//      addInflectionRule('${p0.toLowerCase()}(?i)${prest}\$', (m) => '${p0.toLowerCase()}${prest}');
//    }
//  }

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

final Converter<String, String> SINGULARVERB = new SingularVerbEncoder();
