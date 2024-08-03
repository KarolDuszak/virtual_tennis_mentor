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
