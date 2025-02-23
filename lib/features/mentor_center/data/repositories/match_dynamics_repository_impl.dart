import 'package:dartz/dartz.dart';

import '../../../../core/config/user_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/match_dynamics.dart';
import '../../domain/repositories/match_dynamics_repository.dart';
import '../datasources/match_dynamics_local_datasource.dart';
import '../models/match_dynamics_model.dart';

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
        return Left(CanNotExecuteFailure());
      }

      return Right(await localDataSource.deleteMatchDynamicsInfoById(id));
    } on CouldNotGetException catch (_) {
      return Left(CanNotGetFailure());
    } on LocalDbException catch (_) {
      return Left(LocalDbFailure());
    } catch (error, stacktrace) {
      return Left(UnknownFailure(
          message: error.toString(), stacktrace: stacktrace.toString()));
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
        return Left(CanNotGetFailure());
      }

      return Right(filteredMatchDynamics);
    } on LocalDbException catch (_) {
      return Left(LocalDbFailure());
    } catch (error, stacktrace) {
      return Left(UnknownFailure(
          message: error.toString(), stacktrace: stacktrace.toString()));
    }
  }

  // set language property to custom
  @override
  Future<Either<Failure, MatchDynamics>> insertMatchDynamicInfo(
      String title, String description) async {
    try {
      final result =
          await localDataSource.insertMatchDynamicInfo(title, description);

      return Right(MatchDynamics.fromModel(result));
    } on LocalDbException catch (_) {
      return Left(LocalDbFailure());
    } catch (error, stacktrace) {
      return Left(UnknownFailure(
          message: error.toString(), stacktrace: stacktrace.toString()));
    }
  }

  @override
  Future<Either<Failure, MatchDynamics>> updateMatchDynamicInfo(
      MatchDynamics matchDynamics) async {
    try {
      final modelToUpdate =
          await localDataSource.getMatchDynamicsInfoById(matchDynamics.id);

      if (modelToUpdate.language != 'custom') {
        return Left(CanNotExecuteFailure());
      }
      final updatedModel =
          MatchDynamicsModel.fromEntity(matchDynamics, modelToUpdate.language);
      final result = await localDataSource.updateMatchDynamicInfo(updatedModel);

      return Right(MatchDynamics.fromModel(result));
    } on CouldNotGetException catch (_) {
      return Left(CanNotGetFailure());
    } on LocalDbException catch (_) {
      return Left(LocalDbFailure());
    } catch (error, stacktrace) {
      return Left(UnknownFailure(
          message: error.toString(), stacktrace: stacktrace.toString()));
    }
  }
}
