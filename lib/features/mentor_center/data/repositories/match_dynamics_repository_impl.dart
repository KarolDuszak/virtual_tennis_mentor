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
  Future<Either<Failure, int>> deleteMatchDynamicsInformationById(int id) {
    // TODO: implement deleteMatchDynamicsInformationById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MatchDynamics>>>
      getAllMatchDynamicsInformations() async {
    final preferedLanguage = await userPreferences.language;
    try {
      final allMatchDynamics =
          await localDataSource.getAllMatchDynamicsInformations();

      final filteredMatchDynamics = allMatchDynamics
          .where((matchDynamics) =>
              matchDynamics.language == preferedLanguage ||
              matchDynamics.language == 'custom')
          .toList();

      return Right(filteredMatchDynamics);
    } on CouldNotGetException catch (_) {
      return Left(LocalDbFailure());
    }
  }

  // set language property to custom
  @override
  Future<Either<Failure, MatchDynamics>> insertMatchDynamicInformation(
      String title, String description) {
    // TODO: implement insertMatchDynamicInformation
    throw UnimplementedError();
  }
  // set language property to custom

  @override
  Future<Either<Failure, int>> updateMatchDynamicInformation(
      MatchDynamics matchDynamics) {
    //needs to convert matchDynamics to MatchDynamicsModel which has language property
    // TODO: implement updateMatchDynamicInformationById
    throw UnimplementedError();
  }
}
