import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/data/models/match_dynamics_model.dart';
import 'package:virtual_tennis_mentor/features/mentor_center/domain/entities/match_dynamics.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMatchDynamicsModel = MatchDynamicsModel(
      id: 1, title: 'title', description: 'description', language: 'en');
  final Map<String, dynamic> jsonMap =
      json.decode(fixture('match_dynamics.json'));

  test('should be a subclass of MatchDynamics entity', () async {
    // assert
    expect(tMatchDynamicsModel, isA<MatchDynamics>());
  });

  test(
    'Should return a model from json output',
    () async {
      // arrange

      // act
      final result = MatchDynamicsModel.fromJson(jsonMap);
      // assert
      expect(result, tMatchDynamicsModel);
    },
  );

  test('Should return a json from model', () async {
    // arrange
    // act
    final result = tMatchDynamicsModel.toJson();
    // assert
    expect(result, jsonMap);
  });
}
