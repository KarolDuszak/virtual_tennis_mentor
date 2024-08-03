import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:virtual_tennis_mentor/core/config/preferences.dart';
import 'package:virtual_tennis_mentor/core/platform/custom_io.dart';

import '../../fixtures/fixture_reader.dart';

class MockCustomIo extends Mock implements CustomIo {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late UserPreferences userPreferences;
  late MockCustomIo mockCustomIo;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockCustomIo = MockCustomIo();
    mockSharedPreferences = MockSharedPreferences();
    userPreferences = UserPreferences(mockCustomIo, mockSharedPreferences);
  });

  group(
    'Language Preference',
    () {
      test(
        'should return response length eaqule first 2 when preferences set to default',
        () async {
          // arrange
          when(() => mockSharedPreferences.getString('language'))
              .thenReturn(fixture('user_preferences_default.json'));
          when(() => mockCustomIo.getLocaleName()).thenReturn("long_response");
          // act
          final result = await userPreferences.language;
          // assert
          verify(() => mockCustomIo.getLocaleName());
          expect(result.length, 2);
          expect(result, 'lo');
        },
      );

      test(
        'should return language from shared preferences if not set to default',
        () async {
          // arrange
          when(() => mockSharedPreferences.getString('language'))
              .thenReturn(fixture('user_preferences.json'));
          when(() => mockCustomIo.getLocaleName()).thenReturn("long_response");
          // act
          final result = await userPreferences.language;
          // assert
          expect(result, 'pl');
        },
      );

      test(
        'should default if language stored in preferences is not len(2) and lower case',
        () async {
          // arrange
          when(() => mockSharedPreferences.getString('language'))
              .thenReturn(fixture('bad_user_preferences.json'));
          when(() => mockCustomIo.getLocaleName()).thenReturn("en_UK");
          // act
          final result = await userPreferences.language;
          // assert
          expect(result.length, 2);
          expect(result, 'en');
        },
      );

      test(
        'should return default on get shared preferences exception',
        () async {
          // arrange
          when(() => mockSharedPreferences.getString('language'))
              .thenThrow(Exception());
          when(() => mockCustomIo.getLocaleName()).thenReturn("en_UK");
          // act
          final result = await userPreferences.language;
          // assert
          expect(result.length, 2);
          expect(result, 'en');
        },
      );
    },
  );
}
