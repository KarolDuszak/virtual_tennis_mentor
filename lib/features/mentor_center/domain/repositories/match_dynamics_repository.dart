import 'package:dartz/dartz.dart';
import 'package:virtual_tennis_mentor/core/error/failures.dart';

import '../entities/match_dynamics.dart';

abstract class MatchDynamicRepository{
  Future<Either<Failure, List<MatchDynamics>>> getAllMatchDynamicInformations();
}