import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/match_dynamics.dart';

abstract class MatchDynamicRepository {
  Future<Either<Failure, int>> deleteMatchDynamicsInfoById(int id);

  //returns exit code 200 on success
  Future<Either<Failure, MatchDynamics>> insertMatchDynamicInfo(
      String title, String description);

  Future<Either<Failure, List<MatchDynamics>>> getAllMatchDynamicsInfo();

  //returns exit code 200 on success
  Future<Either<Failure, MatchDynamics>> updateMatchDynamicInfo(
      MatchDynamics matchDynamics);
}
