import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/match_dynamics.dart';
import '../../repositories/match_dynamics_repository.dart';

class GetAllMatchDynamicInformations
    implements UseCase<List<MatchDynamics>, NoParams> {
  final MatchDynamicRepository repository;

  GetAllMatchDynamicInformations(this.repository);

  @override
  Future<Either<Failure, List<MatchDynamics>>> call(NoParams params) async {
    return await repository.getAllMatchDynamicsInformations();
  }
}
