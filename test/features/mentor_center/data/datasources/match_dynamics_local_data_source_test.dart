import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/datasources/match_dynamics_local_datasource.dart';

void main() {
  MatchDynamicsLocalDataSource dataSource;

  group(
    'get database',
    () {
      test(
        'should return passed instance of database',
        () async {
          // arrange
          final String expected =
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
        'should return database from assets if null passed in constructor',
        () async {
          // arrange

          // act
          MatchDynamicsLocalDatasourceImpl dataSourceImpl =
              MatchDynamicsLocalDatasourceImpl.instance;
          dataSourceImpl.database;
          // assert
          expect(true, false);
        },
      );
    },
  );

  group(
    'database operations',
    () {
      setUp(() {});
      group('add to db', () {
        test(
          'should ',
          () async {
            // arrange

            // act

            // assert
            expect(true, false);
          },
        );
      });
    },
  );
}
