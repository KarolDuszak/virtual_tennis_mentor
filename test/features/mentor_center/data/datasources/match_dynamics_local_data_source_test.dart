import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/datasources/match_dynamics_local_datasource.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/models/match_dynamics_model.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group(
    'get database',
    () {
      test(
        'should return injected instance of database',
        () async {
          // arrange
          const expected =
              'sqflite_common_ffi\\databases\\match_dynamics_stub_db\\match_dynamics.db';
          if (Platform.isWindows) {
            sqfliteFfiInit();
          }
          databaseFactory = databaseFactoryFfi;
          final database =
              await openDatabase('match_dynamics_stub_db\\match_dynamics.db');
          MatchDynamicsLocalDatasourceImpl dataSourceImpl =
              MatchDynamicsLocalDatasourceImpl.injectDatabase(database);

          // act
          final result = await dataSourceImpl.database;

          // assert
          expect(result.path, endsWith(expected));
        },
      );

      test(
        'should create new database if instance does not have any',
        () async {
          // arrange
          final expected = 'sqflite_common_ffi\\databases\\mentor_center.db';
          MatchDynamicsLocalDatasourceImpl dataSourceImpl =
              MatchDynamicsLocalDatasourceImpl.instance;
          dataSourceImpl.resetDb();

          sqfliteFfiInit();
          databaseFactory = databaseFactoryFfi;

          // act
          final result = await dataSourceImpl.database;

          // assert
          expect(result.path, endsWith(expected));
        },
      );
    },
  );

  group(
    'database operations',
    () {
      late MatchDynamicsLocalDatasourceImpl dataSourceImpl;
      late MockDatabase mockDatabase;
      const tMatchDynamics = MatchDynamicsModel(
          id: 1,
          title: 'title',
          description: 'description',
          language: 'custom');

      setUp(() async {
        mockDatabase = MockDatabase();
        dataSourceImpl =
            MatchDynamicsLocalDatasourceImpl.injectDatabase(mockDatabase);
      });

      group(
        'add and edit to database',
        () {
          test(
            'should return model if insert was successful',
            () async {
              // arrange
              String title = 'Test Title';
              String description = 'Test Description';
              when(() => mockDatabase.insert('match_informations', any()))
                  .thenAnswer((_) => Future.value(1));

              // act
              final result = await dataSourceImpl.insertMatchDynamicInfo(
                  title, description);

              // assert
              expect(result, isA<MatchDynamicsModel>());
              expect(result.id, 1);
              expect(result.title, title);
              expect(result.description, description);
            },
          );

          test(
            'should update object to new values',
            () async {
              // arrange
              when(() => mockDatabase.update(
                      'match_informations', tMatchDynamics.toJson(),
                      where: 'id=${tMatchDynamics.id}'))
                  .thenAnswer((_) => Future.value(1));

              // act
              final result =
                  await dataSourceImpl.updateMatchDynamicInfo(tMatchDynamics);

              // assert
              expect(result, isA<MatchDynamicsModel>());
              expect(result.id, tMatchDynamics.id);
              expect(result.title, tMatchDynamics.title);
              expect(result.description, tMatchDynamics.description);
              expect(result.language, tMatchDynamics.language);
            },
          );

          test(
            'should throw exception when 0 objects where updated',
            () async {
              // arrange
              when(() => mockDatabase.update(
                      'match_informations', tMatchDynamics.toJson(),
                      where: 'id=${tMatchDynamics.id}'))
                  .thenAnswer((_) => Future.value(0));

              // act
              // assert
              expect(
                  () async => await dataSourceImpl
                      .updateMatchDynamicInfo(tMatchDynamics),
                  throwsException);
            },
          );
        },
      );

      group(
        'deleting from database',
        () {
          test(
            'should return 200 when delete object',
            () async {
              // arrange
              when(() => mockDatabase.delete('match_informations',
                      where: 'id=${tMatchDynamics.id}'))
                  .thenAnswer((_) => Future.value(1));

              // act
              final result =
                  await dataSourceImpl.deleteMatchDynamicsInfoById(1);

              // assert
              expect(result, 200);
            },
          );

          test(
            'should throw exception when 0 is deleted',
            () async {
              when(() =>
                      mockDatabase.delete('match_informations', where: 'id=1'))
                  .thenAnswer((_) => Future.value(0));

              // act
              // assert
              expect(
                  () async =>
                      await dataSourceImpl.deleteMatchDynamicsInfoById(1),
                  throwsException);
            },
          );

          test(
            'should throw exception when more than 1 is deleted',
            () async {
              when(() =>
                      mockDatabase.delete('match_informations', where: 'id=1'))
                  .thenAnswer((_) => Future.value(2));

              // act
              // assert
              expect(
                  () async =>
                      await dataSourceImpl.deleteMatchDynamicsInfoById(1),
                  throwsException);
            },
          );
        },
      );

      group(
        'get from database',
        () {
          test(
            'should getMatchDynamicsInfoById throw exception when not found',
            () async {
              // arrange
              when(() =>
                      mockDatabase.query('match_informations', where: 'id=1'))
                  .thenAnswer((_) => Future.value([<String, dynamic>{}]));
              // act
              // assert
              expect(
                  () async => await dataSourceImpl.getMatchDynamicsInfoById(1),
                  throwsException);
            },
          );

          test(
            'should getMatchDynamicsInfoById throw exception when more than one found',
            () async {
              // arrange
              when(() =>
                      mockDatabase.query('match_informations', where: 'id=1'))
                  .thenAnswer(
                (_) => Future.value(
                  [
                    <String, dynamic>{
                      'id': tMatchDynamics.id,
                      'title': tMatchDynamics.title,
                      'description': tMatchDynamics.description,
                      'language': tMatchDynamics.language,
                    },
                    <String, dynamic>{
                      'id': tMatchDynamics.id + 1,
                      'title': tMatchDynamics.title + '2',
                      'description': tMatchDynamics.description + '2',
                      'language': tMatchDynamics.language,
                    }
                  ],
                ),
              );
              // act
              // assert
              expect(
                  () async => await dataSourceImpl.getMatchDynamicsInfoById(1),
                  throwsException);
            },
          );

          test(
            'should getMatchDynamicsInfoById return model object',
            () async {
              // arrange
              when(() =>
                      mockDatabase.query('match_informations', where: 'id=1'))
                  .thenAnswer(
                (_) => Future.value(
                  [
                    <String, dynamic>{
                      'id': tMatchDynamics.id,
                      'title': tMatchDynamics.title,
                      'description': tMatchDynamics.description,
                      'language': tMatchDynamics.language,
                    }
                  ],
                ),
              );

              // act
              final result = await dataSourceImpl
                  .getMatchDynamicsInfoById(tMatchDynamics.id);

              // assert
              expect(result, isA<MatchDynamicsModel>());
              expect(result.id, tMatchDynamics.id);
              expect(result.title, tMatchDynamics.title);
              expect(result.description, tMatchDynamics.description);
              expect(result.language, tMatchDynamics.language);
            },
          );
        },
      );
    },
  );
}
