import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/match_dynamics_repository.dart';

class InsertMatchDynamicsInformations extends UseCase<MatchDynamics, Params> {
  final MatchDynamicRepository repository;

  InsertMatchDynamicsInformations(this.repository);

  @override
  Future<Either<Failure, MatchDynamics>> call(Params params) async {
    return await repository.insertMatchDynamicInformation(
        params.title, params.description);
  }
}

class Params extends Equatable {
  final String title;
  final String description;

  Params({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
