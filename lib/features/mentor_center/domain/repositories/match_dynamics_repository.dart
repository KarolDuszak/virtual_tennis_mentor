import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/match_dynamics.dart';

abstract class MatchDynamicRepository {
  Future<Either<Failure, int>> deleteMatchDynamicsInformationById(int id);

  //returns exit code 200 on success
  Future<Either<Failure, int>> insertMatchDynamicInformation(
      String title, String description);

  Future<Either<Failure, List<MatchDynamics>>>
      getAllMatchDynamicsInformations();

  //returns exit code 200 on success
  Future<Either<Failure, int>> updateMatchDynamicInformation(
      MatchDynamics matchDynamics);
}
