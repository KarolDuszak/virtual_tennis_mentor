import '../models/match_dynamics_model.dart';

abstract class MatchDynamicsLocalDataSource {
  Future<List<MatchDynamicsModel>> getAllMatchDynamicsInfo();
  Future<int> deleteMatchDynamicsInfoById(int id);
  //should add language 'custom' verify( obj(title,description language='custom'))
  Future<MatchDynamicsModel> insertMatchDynamicInfo(
      String title, String description);
  Future<MatchDynamicsModel> updateMatchDynamicInfo(
      MatchDynamicsModel matchDynamic);
  Future<MatchDynamicsModel> getMatchDynamicsInfoById(int id);
}
