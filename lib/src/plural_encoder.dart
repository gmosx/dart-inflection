part of inflection;

class PluralEncoder extends Converter<String, String> {
  List<List> _pluralInflectionRules = [];

  PluralEncoder() {
    addPluralInflectionRules([
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
      [r'^(ox)$', (m) => 'oxen'],
      [r'^(oxen)$', (m) => 'oxen'],
      [r'(quiz)$', (m) => '${m[1]}zes']
    ].reversed);
  }

  void addPluralInflectionRules(Iterable<List> rules) {
    rules.forEach((r) {
      _pluralInflectionRules.add([new RegExp(r.first), r.last]);
    });
  }

  @override
  String convert(String word) {
    if (!word.isEmpty) {
      for (var r in _pluralInflectionRules) {
        RegExp pattern = r.first;
        if (pattern.hasMatch(word)) {
          return word.replaceAllMapped(pattern, r.last);
        }
      }
    }

    return word;
  }
}

final PLURAL = new PluralEncoder();
