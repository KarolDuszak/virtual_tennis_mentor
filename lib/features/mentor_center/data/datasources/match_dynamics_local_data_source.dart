import '../models/match_dynamics_model.dart';

abstract class MatchDynamicsLocalDataSource {
  Future<List<MatchDynamicsModel>> getAllMatchDynamicsInformations();
  Future<int> deleteMatchDynamicsInformationById(int id);
  Future<int> insertMatchDynamicInformation(String title, String description);
  Future<int> updateMatchDynamicInformation(MatchDynamicsModel matchDynamic);
}
