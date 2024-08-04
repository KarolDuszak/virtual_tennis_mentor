import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

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
    _database = db;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    //TODO: Load database from assets
    throw UnimplementedError();
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
