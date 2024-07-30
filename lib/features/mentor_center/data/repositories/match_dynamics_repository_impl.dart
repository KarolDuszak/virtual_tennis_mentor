import 'package:dartz/dartz.dart';
import 'package:virtual_tennis_mentor/core/config/preferences.dart';
import 'package:virtual_tennis_mentor/core/error/failures.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/datasources/match_dynamics_local_data_source.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/models/match_dynamics_model.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/repositories/match_dynamics_repository.dart';

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

  //get allMatchDynamics needs to get all info for language selected in preferences
  //and ones with'custom' as language
  @override
  Future<Either<Failure, List<MatchDynamics>>>
      getAllMatchDynamicsInformations() async {
    final preferedLanguage = await userPreferences.language;
    final allMatchDynamics =
        await localDataSource.getAllMatchDynamicsInformations();
    final filteredMatchDynamics = allMatchDynamics
        .where((matchDynamics) =>
            matchDynamics.language == preferedLanguage ||
            matchDynamics.language == 'custom')
        .toList();

    return Right(filteredMatchDynamics);
  }

  // set language property to custom
  @override
  Future<Either<Failure, int>> insertMatchDynamicInformation(
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
