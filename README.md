# Inflection.

A port of the Rails/ActiveSupport inflector library to Dart.

In grammar, inflection or inflexion is the modification of a word to express 
different grammatical categories such as tense, mood, voice, aspect, person, 
number, gender and case.

## Usage

A simple usage example:

    import 'package:inflection/inflection.dart';

    main() {
      print(PLURAL.convert("virus")); // => "viri"
      print(SINGULAR.convert("Matrices")); // => "Matrix"
      print(SINGULAR.convert("species")); // => "species"
      print(SNAKE_CASE.convert("CamelCaseName")); // => "camel_case_name"
      print(SPINAL_CASE.convert("CamelCaseName")); // => "camel-case-name"
    }

## Features and bugs

Please file feature requests and bugs at the 
[issue tracker](https://github.com/gmosx/dart-inflection/issues)    