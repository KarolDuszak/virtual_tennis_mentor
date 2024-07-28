import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virtual_tennis_mentor/core/usecases/usecase.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/repositories/match_dynamics_repository.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/usecases/get_all_match_dynamics_informations.dart';

class MockMatchDynamicRepository extends Mock
    implements MatchDynamicRepository {}


void main(){
  late GetAllMatchDynamicInformations usecase;
  late MockMatchDynamicRepository mockMatchDynamicRepository;

  setUp((){
    mockMatchDynamicRepository = MockMatchDynamicRepository();
    usecase = GetAllMatchDynamicInformations(mockMatchDynamicRepository);
  });

  final tAllMatchDynamicInformations = List<MatchDynamics>.
      generate(3, (int index) => MatchDynamics(
          id: index,
          title: index.toString(),
          description: "This is discription nr: ${index.toString()}"
        )
      );

  test(
    'Should get all 3 match dynamic informations from repository',
    () async {
      // arrange

      // when is "On the fly" implementation return Right(tAllMatchDynamicInformations)
      // any time getAllMatchDynamicInformations is called
      when(() => mockMatchDynamicRepository.getAllMatchDynamicsInformations())
        .thenAnswer((_) async => Right(tAllMatchDynamicInformations));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, Right(tAllMatchDynamicInformations));
      verify(() => mockMatchDynamicRepository.getAllMatchDynamicsInformations());
      verifyNoMoreInteractions(mockMatchDynamicRepository);
    }
  );
}