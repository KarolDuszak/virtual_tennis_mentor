import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/models/match_dynamics_model.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';

void main() {
  final tMatchDynamicsModel =
      MatchDynamicsModel(id: 1, title: 'title', description: 'description');

  test('should be a subclass of MatchDynamics entity', () async {
    // assert
    expect(tMatchDynamicsModel, isA<MatchDynamics>());
  });

  group('fromJson', () {});
}
