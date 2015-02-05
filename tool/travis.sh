#!/bin/bash

# Fast fail the script on failures.
set -e

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  lib/inflection.dart \
  test/all_test.dart

# Run the tests.
dart test/all_test.dart
