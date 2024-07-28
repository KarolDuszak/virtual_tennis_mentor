import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/match_dynamics.dart';
import '../repositories/match_dynamics_repository.dart';

class GetAllMatchDynamicInformations{
  final MatchDynamicRepository repository;

  GetAllMatchDynamicInformations(this.repository);

  Future<Either<Failure, List<MatchDynamics>>> call() async {
    return await repository.getAllMatchDynamicsInformations();
  }
}