import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/match_dynamics_repository.dart';

class UpdateMatchDynamicInformationById extends UseCase<int, Params>{
  final MatchDynamicRepository repository;
  
  UpdateMatchDynamicInformationById(this.repository);

  @override
  Future<Either<Failure, int>> call(Params params) async {
    return await repository.updateMatchDynamicInformationById(params.id);
  }
}

class Params extends Equatable{
  final int id;
  
  Params({
    required this.id
  });

  @override
  List<Object?> get props => [id];
  
}