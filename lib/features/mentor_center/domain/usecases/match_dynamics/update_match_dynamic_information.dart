import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/match_dynamics_repository.dart';

class UpdateMatchDynamicInformationById extends UseCase<int, Params> {
  final MatchDynamicRepository repository;

  UpdateMatchDynamicInformationById(this.repository);

  @override
  Future<Either<Failure, int>> call(Params params) async {
    return await repository.updateMatchDynamicInformation(params.matchDynamics);
  }
}

class Params extends Equatable {
  final MatchDynamics matchDynamics;

  Params({required this.matchDynamics});

  @override
  List<Object?> get props => [matchDynamics];
}
