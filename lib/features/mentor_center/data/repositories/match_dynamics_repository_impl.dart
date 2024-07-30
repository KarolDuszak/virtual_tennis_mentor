import 'package:dartz/dartz.dart';
import '../../../../core/config/preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/match_dynamics_local_data_source.dart';
import '../models/match_dynamics_model.dart';
import '../../domain/entities/match_dynamics.dart';
import '../../domain/repositories/match_dynamics_repository.dart';

class MatchDynamicsRepositoryImpl implements MatchDynamicRepository {
  final MatchDynamicsLocalDataSource localDataSource;
  final UserPreferences userPreferences;

  MatchDynamicsRepositoryImpl(
      {required this.localDataSource, required this.userPreferences});

  @override
  Future<Either<Failure, int>> deleteMatchDynamicsInfoById(int id) async {
    try {
      final matchDynamicsToDelete =
          await localDataSource.getMatchDynamicsInfoById(id);

      if (matchDynamicsToDelete.language != 'custom') {
        return Left(CanNotDeleteThisRecord());
      }
      final result = await localDataSource.deleteMatchDynamicsInfoById(id);
      return Right(result);
    } on CouldNotGetException catch (_) {
      return Left(CanNotFindRecordInDb());
    } on LocalDbException catch (_) {
      return Left(LocalDbFailure());
    }
  }

  @override
  Future<Either<Failure, List<MatchDynamics>>> getAllMatchDynamicsInfo() async {
    final preferedLanguage = await userPreferences.language;
    try {
      final allMatchDynamics = await localDataSource.getAllMatchDynamicsInfo();

      final filteredMatchDynamics = allMatchDynamics
          .where((matchDynamics) =>
              matchDynamics.language == preferedLanguage ||
              matchDynamics.language == 'custom')
          .toList();
      if (filteredMatchDynamics.isEmpty) {
        return Left(CanNotFindRecordInDb());
      }
      return Right(filteredMatchDynamics);
    } on LocalDbException catch (_) {
      return Left(LocalDbFailure());
    }
  }

  // set language property to custom
  @override
  Future<Either<Failure, MatchDynamics>> insertMatchDynamicInfo(
      String title, String description) {
    // TODO: implement insertMatchDynamicInformation
    throw UnimplementedError();
  }
  // set language property to custom

  @override
  Future<Either<Failure, int>> updateMatchDynamicInfo(
      MatchDynamics matchDynamics) {
    //needs to convert matchDynamics to MatchDynamicsModel which has language property
    // TODO: implement updateMatchDynamicInformationById
    throw UnimplementedError();
  }
}
