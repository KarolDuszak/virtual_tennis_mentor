import 'package:dartz/dartz.dart';
import 'package:virtual_tennis_mentor/core/error/failures.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/repositories/match_dynamics_repository.dart';

class GetAllMatchDynamicInformations{
  final MatchDynamicRepository repository;

  GetAllMatchDynamicInformations(this.repository);

  Future<Either<Failure, List<MatchDynamics>>> execute() async {
    return await repository.getAllMatchDynamicInformations();
  }
}