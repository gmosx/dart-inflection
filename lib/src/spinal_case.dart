library inflection.spinal_case;

import 'dart:convert';

final _UNDERSCODE_RE0 = new RegExp(r'''([A-Z\d]+)([A-Z][a-z])''');
final _UNDERSCODE_RE1 = new RegExp(r'''([a-z\d])([A-Z])''');
final _UNDERSCODE_RE2 = new RegExp(r'[_\s]');

class SpinalCaseEncoder extends Converter<String, String> {
  const SpinalCaseEncoder();

  /// Converts the input [phrase] to 'spinal case', i.e. a hyphen-delimited,
  /// lowercase form. Also known as 'kebab case' or 'lisp case'.
  @override
  String convert(String phrase) {
    return phrase
        .replaceAllMapped(_UNDERSCODE_RE0, (match) => "${match[1]}-${match[2]}")
        .replaceAllMapped(_UNDERSCODE_RE1, (match) => "${match[1]}-${match[2]}")
        .replaceAll(_UNDERSCODE_RE2, "-")
        .toLowerCase();
  }
}

const Converter<String, String> SPINAL_CASE = const SpinalCaseEncoder();