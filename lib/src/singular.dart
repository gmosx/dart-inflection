library inflection.singular;

import 'dart:convert';

import 'uncountable_nouns.dart';
import 'irregular_plural_nouns.dart';

class SingularEncoder extends Converter<String, String> {
  final List<List> _inflectionRules = [];

  SingularEncoder() {
    irregularPluralNouns.forEach((singular, plural) {
      addIrregularInflectionRule(singular, plural);
    });

    [
      [r's$', (m) => ''],
      [r'(ss)$', (m) => m[1]],
      [r'(n)ews$', (m) => '${m[1]}ews'], // TODO: uncountable?
      [r'([ti])a$', (m) => '${m[1]}um'],
      [r'((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)(sis|ses)$', (m) => '${m[1]}sis'],
      [r'(^analy)(sis|ses)$', (m) => '${m[1]}sis'], // TODO: not needed?
      [r'([^f])ves$', (m) => '${m[1]}fe'],
      [r'(hive|tive)s$', (m) => m[1]],
      [r'([lr])ves$', (m) => '${m[1]}f'],
      [r'([^aeiouy]|qu)ies$', (m) => '${m[1]}y'],
      [r'(s)eries$', (m) => '${m[1]}eries'], // TODO: uncountable
      [r'(m)ovies$', (m) => '${m[1]}ovie'],
      [r'(x|ch|ss|sh)es$', (m) => m[1]],
      [r'^(m|l)ice$', (m) => '${m[1]}ouse'],
      [r'(bus)(es)?$', (m) => m[1]],
      [r'(shoe)s$', (m) => m[1]],
      [r'(cris|test)(is|es)$', (m) => '${m[1]}is'],
      [r'^(a)x[ie]s$', (m) => '${m[1]}xis'],
      [r'(octop|vir)(us|i)$', (m) => '${m[1]}us'],
      [r'(alias|status)(es)?$', (m) => m[1]],
      [r'^(ox)en', (m) => m[1]],
      [r'(vert|ind)ices$', (m) => '${m[1]}ex'],
      [r'(matr)ices$', (m) => '${m[1]}ix'],
      [r'(quiz)zes$', (m) => m[1]],
      [r'(database)s$', (m) => m[1]]
    ].reversed.forEach((rule) => addInflectionRule(rule.first, rule.last));
  }

  void addInflectionRule(String plural, dynamic singular) {
    _inflectionRules.add([new RegExp(plural, caseSensitive: false), singular]);
  }

  void addIrregularInflectionRule(String singular, String plural) {
    final s0 = singular.substring(0, 1);
    final srest = singular.substring(1);
    final p0 = plural.substring(0, 1);
    final prest = plural.substring(1);

    if (s0.toUpperCase() == p0.toUpperCase()) {
      addInflectionRule('(${s0})${srest}\$', (m) => '${m[1]}${srest}');
      addInflectionRule('(${p0})${prest}\$', (m) => '${m[1]}${srest}');
    } else {
      addInflectionRule('${s0.toUpperCase()}(?i)${srest}\$', (m) => '${s0.toUpperCase()}${srest}');
      addInflectionRule('${s0.toLowerCase()}(?i)${srest}\$', (m) => '${s0.toUpperCase()}${srest}');
      addInflectionRule('${p0.toUpperCase()}(?i)${prest}\$', (m) => '${s0.toUpperCase()}${srest}');
      addInflectionRule('${p0.toLowerCase()}(?i)${prest}\$', (m) => '${s0.toLowerCase()}${srest}');
    }
  }

  @override
  String convert(String word) {
    if (!word.isEmpty) {
      if (uncountableNouns.contains(word.toLowerCase())) {
        return word;
      } else {
        for (var r in _inflectionRules) {
          RegExp pattern = r.first;
          if (pattern.hasMatch(word)) {
            return word.replaceAllMapped(pattern, r.last);
          }
        }
      }
    }

    return word;
  }
}

final Converter<String, String> SINGULAR = new SingularEncoder();
