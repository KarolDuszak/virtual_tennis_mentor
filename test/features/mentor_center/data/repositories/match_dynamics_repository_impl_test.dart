import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virtual_tennis_mentor/core/config/preferences.dart';
import 'package:virtual_tennis_mentor/core/error/exceptions.dart';
import 'package:virtual_tennis_mentor/core/error/failures.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/datasources/match_dynamics_local_data_source.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/models/match_dynamics_model.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/repositories/match_dynamics_repository_impl.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';

class MockLocalDataSource extends Mock
    implements MatchDynamicsLocalDataSource {}

class MockUserPreferences extends Mock implements UserPreferences {}

String getStubLanguage(int index) {
  if (index % 2 == 0) {
    return 'en-UK';
  }
  if (index % 3 == 0) {
    return 'custom';
  }
  return 'pl-PL';
}

void main() {
  late MatchDynamicsRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockUserPreferences mockUserPreferences;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockUserPreferences = MockUserPreferences();
    repository = MatchDynamicsRepositoryImpl(
        localDataSource: mockLocalDataSource,
        userPreferences: mockUserPreferences);
  });

  group(
    'getAllMatchDynamicsInformations',
    () {
      final tAllMatchDynamics = List<MatchDynamicsModel>.generate(
        10,
        (int index) => MatchDynamicsModel(
            id: index,
            title: index.toString(),
            description: "This is discription nr: ${index.toString()}",
            language: getStubLanguage(index)),
      );

      test(
        'should check which language is selected',
        () async {
          // arrange
          when(() => mockUserPreferences.language)
              .thenAnswer((_) async => "en-UK");
          when(() => mockLocalDataSource.getAllMatchDynamicsInfo())
              .thenAnswer((_) async => tAllMatchDynamics);
          // act
          await repository.getAllMatchDynamicsInfo();
          // assert
          verify(() => mockUserPreferences.language);
        },
      );

      test(
        'should filter only for selected language in preferences if customs are not added',
        () async {
          // arrange
          final tMatchDynamicsNoCustom =
              tAllMatchDynamics.getRange(0, 2).toList();
          final tEnglishMatchDynamics = tMatchDynamicsNoCustom
              .where((i) => i.language == 'en-UK')
              .toList();

          when(() => mockUserPreferences.language)
              .thenAnswer((_) async => "en-UK");
          when(() => mockLocalDataSource.getAllMatchDynamicsInfo())
              .thenAnswer((_) async => tMatchDynamicsNoCustom);

          //making sure prepared data is correct
          expect(tEnglishMatchDynamics.any((item) => item.language == 'en-UK'),
              true);

          // act
          final result = await repository.getAllMatchDynamicsInfo();
          // assert
          expect(result, isA<Right>());
          expect(
              result.fold((l) => l, (r) => r), equals(tEnglishMatchDynamics));
        },
      );

      test(
        'should get both selected language and custom if custom exists inside',
        () async {
          // arrange
          final tCustomAndPolishDynamics = tAllMatchDynamics
              .where((i) => i.language == 'custom' || i.language == 'pl-PL')
              .toList();

          when(() => mockUserPreferences.language)
              .thenAnswer((_) async => "pl-PL");
          when(() => mockLocalDataSource.getAllMatchDynamicsInfo())
              .thenAnswer((_) async => tAllMatchDynamics);

          // making sure prepared data is correct
          expect(
              tCustomAndPolishDynamics.any((item) => item.language == 'custom'),
              true);
          expect(
              tCustomAndPolishDynamics.any((item) => item.language == 'pl-PL'),
              true);
          // act
          final result = await repository.getAllMatchDynamicsInfo();

          // assert
          expect(result, isA<Right>());
          expect(result.fold((l) => l, (r) => r),
              equals(tCustomAndPolishDynamics));
        },
      );

      test(
        'should return failure when no record found in db',
        () async {
          // arrange
          when(() => mockUserPreferences.language)
              .thenAnswer((_) async => "en-UK");
          when(() => mockLocalDataSource.getAllMatchDynamicsInfo())
              .thenAnswer((_) async => List.empty());
          // act
          final result = await repository.getAllMatchDynamicsInfo();
          // assert
          verify(() => mockLocalDataSource.getAllMatchDynamicsInfo());
          expect(result, equals(Left(CanNotGetFailure())));
        },
      );

      test(
        'should return failure on localdb exception',
        () async {
          // arrange
          when(() => mockUserPreferences.language)
              .thenAnswer((_) async => "en-UK");
          when(() => mockLocalDataSource.getAllMatchDynamicsInfo())
              .thenThrow(LocalDbException());
          // act
          final result = await repository.getAllMatchDynamicsInfo();
          // assert
          verify(() => mockLocalDataSource.getAllMatchDynamicsInfo());
          expect(result, equals(Left(LocalDbFailure())));
        },
      );
    },
  );

  group(
    'deleteMatchDynamicsInformationById',
    () {
      const tIdToRemove = 14;

      const tMatchDynamicsCustom = MatchDynamicsModel(
          id: 14,
          title: 'title',
          description: 'description',
          language: 'custom');

      const tMatchDynamicsNotCustom = MatchDynamicsModel(
          id: 14,
          title: 'title',
          description: 'description',
          language: 'en-UK');
      test(
        'should get fail when trying to delete not custom note',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove))
              .thenAnswer((_) async => tMatchDynamicsNotCustom);

          // act
          final result =
              await repository.deleteMatchDynamicsInfoById(tIdToRemove);
          // assert
          verify(
              () => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove));
          expect(result, equals(Left(CanNotExecuteFailure())));
        },
      );

      test(
        'should get 200 exit code on deleting custom match dynamic info',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove))
              .thenAnswer((_) async => tMatchDynamicsCustom);
          when(() =>
                  mockLocalDataSource.deleteMatchDynamicsInfoById(tIdToRemove))
              .thenAnswer((_) async => 200);

          // act
          final result =
              await repository.deleteMatchDynamicsInfoById(tIdToRemove);

          // assert
          verify(
              () => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove));
          expect(result, const Right(200));
        },
      );

      test(
        'should return fail when record not found in db',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove))
              .thenThrow(CouldNotGetException());
          // act
          final result =
              await repository.deleteMatchDynamicsInfoById(tIdToRemove);

          // assert
          verify(
              () => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove));
          expect(result, equals(Left(CanNotGetFailure())));
        },
      );

      test(
        'should return failure on localdb exception',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(tIdToRemove))
              .thenAnswer((_) async => tMatchDynamicsCustom);
          when(() =>
                  mockLocalDataSource.deleteMatchDynamicsInfoById(tIdToRemove))
              .thenThrow(LocalDbException());
          // act
          final result =
              await repository.deleteMatchDynamicsInfoById(tIdToRemove);
          // assert
          verify(() =>
              mockLocalDataSource.deleteMatchDynamicsInfoById(tIdToRemove));
          expect(result, equals(Left(LocalDbFailure())));
        },
      );
    },
  );

  group(
    'updateMatchDynamicInfo',
    () {
      const tMatchDynamicEntity = MatchDynamics(
          id: 3, title: 'updated title', description: 'updated description');

      const tUpdatedModel = MatchDynamicsModel(
          id: 3,
          title: 'updated title',
          description: 'updated description',
          language: 'custom');

      const tMatchDynamicsCustom = MatchDynamicsModel(
          id: 3,
          title: 'title',
          description: 'description',
          language: 'custom');

      const tMatchDynamicsNotCustom = MatchDynamicsModel(
          id: 3, title: 'title', description: 'description', language: 'en-UK');

      test(
        'should not update when records language is not custom',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(3))
              .thenAnswer((_) async => tMatchDynamicsNotCustom);

          // act
          final result =
              await repository.updateMatchDynamicInfo(tMatchDynamicEntity);

          // assert
          expect(result, equals(Left(CanNotExecuteFailure())));
        },
      );

      test(
        'should return updated object on success',
        () async {
          // arrange
          when(() => mockLocalDataSource
                  .getMatchDynamicsInfoById(tMatchDynamicEntity.id))
              .thenAnswer((_) async => tMatchDynamicsCustom);
          when(
            () => mockLocalDataSource.updateMatchDynamicInfo(tUpdatedModel),
          ).thenAnswer((_) async => tUpdatedModel);

          // act
          final result =
              await repository.updateMatchDynamicInfo(tMatchDynamicEntity);

          // assert
          verify(() => mockLocalDataSource
              .getMatchDynamicsInfoById(tMatchDynamicEntity.id));
          verify(
              () => mockLocalDataSource.updateMatchDynamicInfo(tUpdatedModel));
          expect(result, equals(const Right(tMatchDynamicEntity)));
        },
      );

      test(
        'should return failure when object not found in db',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(3))
              .thenThrow(CouldNotGetException());

          // act
          final result =
              await repository.updateMatchDynamicInfo(tMatchDynamicEntity);

          // assert
          verify(() => mockLocalDataSource.getMatchDynamicsInfoById(3));
          expect(result, equals(Left(CanNotGetFailure())));
        },
      );

      test(
        'should return failure on localdb exception',
        () async {
          // arrange
          when(() => mockLocalDataSource.getMatchDynamicsInfoById(3))
              .thenAnswer((_) async => tMatchDynamicsCustom);
          when(() => mockLocalDataSource.updateMatchDynamicInfo(tUpdatedModel))
              .thenThrow(LocalDbException());

          // act
          final result =
              await repository.updateMatchDynamicInfo(tMatchDynamicEntity);

          // assert
          expect(result, equals(Left(LocalDbFailure())));
        },
      );
    },
  );
}
