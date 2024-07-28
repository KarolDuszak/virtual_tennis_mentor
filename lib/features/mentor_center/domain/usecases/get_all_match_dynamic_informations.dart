import 'package:dartz/dartz.dart';
import 'package:virtual_tennis_mentor/core/error/failures.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamic_entity.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/repositories/match_dynamic_repository.dart';

class GetAllMatchDynamicInformations{
  final MatchDynamicRepository repository;

  GetAllMatchDynamicInformations(this.repository);

  Future<Either<Failure, List<MatchDynamicEntity>>> execute() async {
    return await repository.getAllMatchDynamicInformations();
  }
}