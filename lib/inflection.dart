/// In grammar, inflection or inflexion is the modification of a word to express
/// different grammatical categories such as tense, mood, voice, aspect, person,
/// number, gender and case.
///
/// [ActiveSupport Inflector](https://github.com/rails/rails/tree/master/activesupport/lib/active_support/inflector)
/// [Letter case](http://en.wikipedia.org/wiki/Letter_case#Special_case_styles)
library inflection;

import 'src/plural.dart';
import 'src/plural_verb.dart';
import 'src/singular.dart';
import 'src/snake_case.dart';
import 'src/spinal_case.dart';

export 'src/plural.dart';
export 'src/plural_verb.dart';
export 'src/singular.dart';
export 'src/snake_case.dart';
export 'src/spinal_case.dart';

String pluralize(String word) => PLURAL.convert(word);

String pluralizeVerb(String word) => PLURALVERB.convert(word);

String singularize(String word) => SINGULAR.convert(word);

String convertToSnakeCase(String word) => SNAKE_CASE.convert(word);

String convertToSpinalCase(String word) => SPINAL_CASE.convert(word);
