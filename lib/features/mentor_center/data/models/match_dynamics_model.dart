import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/match_dynamics.dart';

part 'match_dynamics_model.g.dart';

@JsonSerializable()
class MatchDynamicsModel extends MatchDynamics {
  final String language;

  const MatchDynamicsModel(
      {required super.id,
      required super.title,
      required super.description,
      required this.language});

  factory MatchDynamicsModel.fromEntity(
      MatchDynamics entity, String modelLanguage) {
    return MatchDynamicsModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      language: modelLanguage,
    );
  }

  factory MatchDynamicsModel.fromJson(Map<String, dynamic> json) =>
      _$MatchDynamicsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDynamicsModelToJson(this);
}
