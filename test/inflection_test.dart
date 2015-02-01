import 'package:unittest/unittest.dart';

import 'package:inflection/inflection.dart';

void main() {
  group("Letter case inflections:", () {
    test("convertToSnakeCase", () {
      expect(convertToSnakeCase('CamelCaseName'), equals('camel_case_name'));
      expect(convertToSnakeCase('propertyName'), equals('property_name'));
      expect(convertToSnakeCase('property'), equals('property'));
      expect(convertToSnakeCase(''), equals(''));
    });
  });
}