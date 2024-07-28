import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_tennis_mentor/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/match_dynamics.dart';
import '../repositories/match_dynamics_repository.dart';

class GetAllMatchDynamicInformations implements UseCase<List<MatchDynamics>, Params>{
  final MatchDynamicRepository repository;

  GetAllMatchDynamicInformations(this.repository);

  @override
  Future<Either<Failure, List<MatchDynamics>>> call(Params params) async {
    return await repository.getAllMatchDynamicsInformations();
  }
}

class Params extends Equatable{
  @override
  List<Object?> get props => <Object?>[];
}