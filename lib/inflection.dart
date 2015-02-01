library inflection;

// TODO: consider renaming to grammatical_inflection.
// TODO: consider implementing a Codec for some functions.

// https://github.com/rails/rails/tree/master/activesupport/lib/active_support/inflector
// http://en.wikipedia.org/wiki/Letter_case#Special_case_styles

/// Returns the plural form of the word in the string.
String convertToPlural(String word) {
  return word;
}

final UNDERSCODE_RE0 = new RegExp(r'''([A-Z\d]+)([A-Z][a-z])''');
final UNDERSCODE_RE1 = new RegExp(r'''([a-z\d])([A-Z])''');

/// Makes an underscored, lowercase form from the input [phrase].
String convertToSnakeCase(String phrase) {
  // TODO: word.gsub!(/(?:([A-Za-z\d])|^)(#{inflections.acronym_regex})(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }

  return phrase
      .replaceAllMapped(UNDERSCODE_RE0, (match) => "${match[1]}_${match[2]}")
      .replaceAllMapped(UNDERSCODE_RE1, (match) => "${match[1]}_${match[2]}")
      .replaceAll("-", "_")
      .toLowerCase();
}