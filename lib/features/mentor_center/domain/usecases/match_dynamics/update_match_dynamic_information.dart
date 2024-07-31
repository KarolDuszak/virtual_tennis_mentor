import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/match_dynamics.dart';
import '../../repositories/match_dynamics_repository.dart';

class UpdateMatchDynamicInformationById extends UseCase<MatchDynamics, Params> {
  final MatchDynamicRepository repository;

  UpdateMatchDynamicInformationById(this.repository);

  @override
  Future<Either<Failure, MatchDynamics>> call(Params params) async {
    return await repository.updateMatchDynamicInfo(params.matchDynamics);
  }
}

class Params extends Equatable {
  final MatchDynamics matchDynamics;

  Params({required this.matchDynamics});

  @override
  List<Object?> get props => [matchDynamics];
}
