import '../models/match_dynamics_model.dart';

abstract class MatchDynamicsLocalDataSource {
  Future<List<MatchDynamicsModel>> getAllMatchDynamicsInfo();
  Future<int> deleteMatchDynamicsInfoById(int id);
  Future<int> insertMatchDynamicInfo(String title, String description);
  Future<int> updateMatchDynamicInfo(MatchDynamicsModel matchDynamic);
  Future<MatchDynamicsModel> getMatchDynamicsInfoById(int id);
}
