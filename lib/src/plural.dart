library inflection.plural;

import 'dart:convert';

import 'uncountable_nouns.dart';
import 'irregular_plural_nouns.dart';

class PluralEncoder extends Converter<String, String> {
  final List<List> _inflectionRules = [];

  PluralEncoder() {
    irregularPluralNouns.forEach((singular, plural) {
      addIrregularInflectionRule(singular, plural);
    });

    [
      [r'$', (m) => 's'],
      [r's$', (m) => 's'],
      [r'^(ax|test)is$', (m) => '${m[1]}es'],
      [r'(octop|vir)us$', (m) => '${m[1]}i'],
      [r'(octop|vir)i$', (m) => m[0]],
      [r'(alias|status)$', (m) => '${m[1]}es'],
      [r'(bu)s$', (m) => '${m[1]}ses'],
      [r'(buffal|tomat)o$', (m) => '${m[1]}oes'],
      [r'([ti])um$', (m) => '${m[1]}a'],
      [r'([ti])a$', (m) => m[0]],
      [r'sis$', (m) => 'ses'],
      [r'(?:([^f])fe|([lr])f)$', (m) => '${m[1]}${m[2]}ves'],
      [r'([^aeiouy]|qu)y$', (m) => '${m[1]}ies'],
      [r'(x|ch|ss|sh)$', (m) => '${m[1]}es'],
      [r'(matr|vert|ind)(?:ix|ex)$', (m) => '${m[1]}ices'],
      [r'^(m|l)ouse$', (m) => '${m[1]}ice'],
      [r'^(m|l)ice$', (m) => m[0]],
      [r'^(ox)$', (m) => '${m[1]}en'],
      [r'^(oxen)$', (m) => m[1]],
      [r'(quiz)$', (m) => '${m[1]}zes']
    ].reversed.forEach((rule) => addInflectionRule(rule.first, rule.last));
  }

  void addInflectionRule(String singular, dynamic plural) {
    _inflectionRules.add([new RegExp(singular, caseSensitive: false), plural]);
  }

  void addIrregularInflectionRule(String singular, String plural) {
    final s0 = singular.substring(0, 1);
    final srest = singular.substring(1);
    final p0 = plural.substring(0, 1);
    final prest = plural.substring(1);

    if (s0.toUpperCase() == p0.toUpperCase()) {
      addInflectionRule('(${s0})${srest}\$', (m) => '${m[1]}${prest}');
      addInflectionRule('(${p0})${prest}\$', (m) => '${m[1]}${prest}');
    } else {
      addInflectionRule('${s0.toUpperCase()}(?i)${srest}\$', (m) => '${p0.toUpperCase()}${prest}');
      addInflectionRule('${s0.toLowerCase()}(?i)${srest}\$', (m) => '${p0.toUpperCase()}${prest}');
      addInflectionRule('${p0.toUpperCase()}(?i)${prest}\$', (m) => '${p0.toUpperCase()}${prest}');
      addInflectionRule('${p0.toLowerCase()}(?i)${prest}\$', (m) => '${p0.toLowerCase()}${prest}');
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

final Converter<String, String> PLURAL = new PluralEncoder();
