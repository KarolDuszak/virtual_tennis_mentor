import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virtual_tennis_mentor/core/config/preferences.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/datasources/match_dynamics_local_data_source.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/repositories/match_dynamics_repository_impl.dart';

class MockLocalDataSource extends Mock
    implements MatchDynamicsLocalDataSource {}

class MockLanguageInfo extends Mock implements LanguageInfo {}

void main() {
  MatchDynamicsRepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;
  MockLanguageInfo mockLanguageInfo;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockLanguageInfo = MockLanguageInfo();
    repository = MatchDynamicsRepositoryImpl(
        localDataSource: mockLocalDataSource, languageInfo: mockLanguageInfo);
  });
}
