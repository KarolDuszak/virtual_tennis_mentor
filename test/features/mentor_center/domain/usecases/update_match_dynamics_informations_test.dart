import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/repositories/match_dynamics_repository.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/usecases/match_dynamics/update_match_dynamic_information.dart';

class MockMatchDynamicRepository extends Mock
    implements MatchDynamicRepository {}

void main() {
  late UpdateMatchDynamicInformationById usecase;
  late MockMatchDynamicRepository mockMatchDynamicRepository;

  setUp(() {
    mockMatchDynamicRepository = MockMatchDynamicRepository();
    usecase = UpdateMatchDynamicInformationById(mockMatchDynamicRepository);
  });

  MatchDynamics tMatchDynamics =
      MatchDynamics(id: 1, title: 'title', description: 'description');

  test('Should obtain success exit code', () async {
    // arrange

    // when is "On the fly" implementation return Right(tAllMatchDynamicInformations)
    // any time getAllMatchDynamicInformations is called
    when(() =>
            mockMatchDynamicRepository.updateMatchDynamicInfo(tMatchDynamics))
        .thenAnswer((_) async => Right(tMatchDynamics));

    // act
    final result = await usecase(Params(matchDynamics: tMatchDynamics));

    // assert
    expect(result, Right(tMatchDynamics));
    verify(() =>
        mockMatchDynamicRepository.updateMatchDynamicInfo(tMatchDynamics));
    verifyNoMoreInteractions(mockMatchDynamicRepository);
  });
}
