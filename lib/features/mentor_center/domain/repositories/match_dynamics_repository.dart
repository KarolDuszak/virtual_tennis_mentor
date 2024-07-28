import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../entities/match_dynamics.dart';

abstract class MatchDynamicRepository{
  //returns exit code 200 on success
  Future<Either<Failure, int>> insertMatchDynamicInformation(MatchDynamics matchDynamics);
  //returns exit code 200 on success
  Future<Either<Failure, int>> updateMatchDynamicInformationById(int id);
  Future<Either<Failure, List<MatchDynamics>>> getAllMatchDynamicsInformations();
  Future<Either<Failure, int>> deleteMatchDynamicsInformationById(int id);
}