import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:virtual_tennis_mentor/core/config/preferences.dart';
import 'package:virtual_tennis_mentor/core/platform/custom_io.dart';

class MockCustomIo extends Mock implements CustomIo {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late UserPreferencesImpl userPreferences;
  late MockCustomIo mockCustomIo;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockCustomIo = MockCustomIo();
    mockSharedPreferences = MockSharedPreferences();
    userPreferences = UserPreferencesImpl(mockCustomIo, mockSharedPreferences);
  });

  group(
    'Language Preference',
    () {
      test(
        'should return response length eaqule first 2 when preferences set to default',
        () async {
          // arrange
          //when(() => mockSharedPreferences).thenReturn("default")
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

          // act

          // assert
        },
      );

      test(
        'should default if language stored in preferences is not len(2) and lower case',
        () async {
          // arrange

          // act

          // assert
        },
      );

      test(
        'should set language to preferences len(2) and lower case',
        () async {
          // arrange

          // act

          // assert
        },
      );
    },
  );
}
