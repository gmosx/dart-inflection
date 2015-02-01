import 'package:unittest/unittest.dart';

import 'package:inflection/inflection.dart';

void main() {
  group("Letter case inflections:", () {
    test("convertToSnakeCase", () {
      expect(convertToSnakeCase('CamelCaseName'), equals('camel_case_name'));
      expect(convertToSnakeCase('propertyName'), equals('property_name'));
      expect(convertToSnakeCase('property'), equals('property'));
      expect(convertToSnakeCase('lisp-case'), equals('lisp_case'));
      expect(convertToSnakeCase(''), equals(''));
    });

    test("convertToSpinalCase", () {
      expect(convertToSpinalCase('CamelCaseName'), equals('camel-case-name'));
      expect(convertToSpinalCase('propertyName'), equals('property-name'));
      expect(convertToSpinalCase('property'), equals('property'));
      expect(convertToSpinalCase('snake_case'), equals('snake-case'));
      expect(convertToSpinalCase(''), equals(''));
    });
  });
}