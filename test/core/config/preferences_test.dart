import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:virtual_tennis_mentor/core/config/preferences.dart';
import 'package:virtual_tennis_mentor/core/platform/custom_io.dart';

class MockCustomIo extends Mock implements CustomIo {}

void main() {
  late UserPreferencesImpl userPreferences;
  late MockCustomIo mockCustomIo;
  setUp(() {
    mockCustomIo = MockCustomIo();
    userPreferences = UserPreferencesImpl(mockCustomIo);
  });

  test(
    'should get response length eaqule first 2',
    () async {
      // arrange
      when(() => mockCustomIo.getLocaleName()).thenReturn("long_response");
      // act
      final result = await userPreferences.language;
      // assert
      verify(() => mockCustomIo.getLocaleName());
      expect(result.length, 2);
      expect(result, 'lo');
    },
  );
}
