import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/repositories/match_dynamics_repository.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/usecases/match_dynamics/update_match_dynamic_information_by_id.dart';

class MockMatchDynamicRepository extends Mock
    implements MatchDynamicRepository {}

void main() {
  late UpdateMatchDynamicInformationById usecase;
  late MockMatchDynamicRepository mockMatchDynamicRepository;

  setUp(() {
    mockMatchDynamicRepository = MockMatchDynamicRepository();
    usecase = UpdateMatchDynamicInformationById(mockMatchDynamicRepository);
  });

  int tSuccessExitCode = 200;
  int tId = 10;

  test('Should obtain success exit code', () async {
    // arrange

    // when is "On the fly" implementation return Right(tAllMatchDynamicInformations)
    // any time getAllMatchDynamicInformations is called
    when(() =>
            mockMatchDynamicRepository.updateMatchDynamicInformationById(tId))
        .thenAnswer((_) async => Right(tSuccessExitCode));

    // act
    final result = await usecase(Params(id: tId));

    // assert
    expect(result, Right(tSuccessExitCode));
    verify(() =>
        mockMatchDynamicRepository.updateMatchDynamicInformationById(tId));
    verifyNoMoreInteractions(mockMatchDynamicRepository);
  });
}
