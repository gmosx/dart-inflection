library inflection;

List<String> _uncountableWords = [];

// TODO: implement as singleton class, to support configuration.
// TODO: consider renaming to grammatical_inflection.
// TODO: consider implementing a Codec for some functions.
// TODO: add special handling code for 'acronyms'.

// https://github.com/rails/rails/tree/master/activesupport/lib/active_support/inflector
// http://en.wikipedia.org/wiki/Letter_case#Special_case_styles

final UNDERSCODE_RE0 = new RegExp(r'''([A-Z\d]+)([A-Z][a-z])''');
final UNDERSCODE_RE1 = new RegExp(r'''([a-z\d])([A-Z])''');

/// Converts the input [phrase] to 'camel case'.
String convertToCamelCase(String phrase, {uppercaseFirstLetter: true}) {
  return phrase
      .replaceAllMapped(UNDERSCODE_RE0, (match) => "${match[1]}_${match[2]}")
      .replaceAllMapped(UNDERSCODE_RE1, (match) => "${match[1]}_${match[2]}")
      .replaceAll("-", "_")
      .toLowerCase();
}

/// Converts the input [phrase] to 'snake case', i.e. an underscored, lowercase
/// form.
String convertToSnakeCase(String phrase) {
  return phrase
      .replaceAllMapped(UNDERSCODE_RE0, (match) => "${match[1]}_${match[2]}")
      .replaceAllMapped(UNDERSCODE_RE1, (match) => "${match[1]}_${match[2]}")
      .replaceAll("-", "_")
      .toLowerCase();
}

/// Converts the input [phrase] to 'spinal case', i.e. a hyphen-delimited,
/// lowercase form. Also known as 'kebab case' or 'lisp case'.
String convertToSpinalCase(String phrase) {
  return phrase
      .replaceAllMapped(UNDERSCODE_RE0, (match) => "${match[1]}-${match[2]}")
      .replaceAllMapped(UNDERSCODE_RE1, (match) => "${match[1]}-${match[2]}")
      .replaceAll("_", "-")
      .toLowerCase();
}