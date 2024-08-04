import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/match_dynamics_model.dart';

abstract class MatchDynamicsLocalDataSource {
  Future<List<MatchDynamicsModel>> getAllMatchDynamicsInfo();

  Future<int> deleteMatchDynamicsInfoById(int id);

  Future<MatchDynamicsModel> insertMatchDynamicInfo(
      String title, String description);

  Future<MatchDynamicsModel> updateMatchDynamicInfo(
      MatchDynamicsModel matchDynamic);

  Future<MatchDynamicsModel> getMatchDynamicsInfoById(int id);
}

class MatchDynamicsLocalDatasourceImpl implements MatchDynamicsLocalDataSource {
  static final MatchDynamicsLocalDatasourceImpl instance =
      MatchDynamicsLocalDatasourceImpl._internal();

  static Database? _database;

  MatchDynamicsLocalDatasourceImpl._internal();

  MatchDynamicsLocalDatasourceImpl.injectDatabase(Database db) {
    if ((Platform.isLinux || Platform.isWindows || Platform.isMacOS) &&
        Platform.environment.containsKey('FLUTTER_TEST')) {
      print("TEST MODE");
      _database = db;
    }
  }

  void resetDb() {
    if ((Platform.isLinux || Platform.isWindows || Platform.isMacOS) &&
        Platform.environment.containsKey('FLUTTER_TEST')) {
      print("TEST MODE");
      _database = null;
    }
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''CREATE TABLE match_informations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      language TEXT NOT NULL
    )''');
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/mentor_center.db';

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  @override
  Future<int> deleteMatchDynamicsInfoById(int id) {
    // TODO: implement deleteMatchDynamicsInfoById
    throw UnimplementedError();
  }

  @override
  Future<List<MatchDynamicsModel>> getAllMatchDynamicsInfo() {
    // TODO: implement getAllMatchDynamicsInfo
    throw UnimplementedError();
  }

  @override
  Future<MatchDynamicsModel> getMatchDynamicsInfoById(int id) {
    // TODO: implement getMatchDynamicsInfoById
    throw UnimplementedError();
  }

  @override
  Future<MatchDynamicsModel> insertMatchDynamicInfo(
      String title, String description) {
    // TODO: implement insertMatchDynamicInfo
    throw UnimplementedError();
  }

  @override
  Future<MatchDynamicsModel> updateMatchDynamicInfo(
      MatchDynamicsModel matchDynamic) {
    // TODO: implement updateMatchDynamicInfo
    throw UnimplementedError();
  }
}
