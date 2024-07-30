import '../../domain/entities/match_dynamics.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_dynamics_model.g.dart';

@JsonSerializable()
class MatchDynamicsModel extends MatchDynamics {
  String language;

  MatchDynamicsModel(
      {required super.id,
      required super.title,
      required super.description,
      required this.language});

  factory MatchDynamicsModel.fromJson(Map<String, dynamic> json) =>
      _$MatchDynamicsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDynamicsModelToJson(this);
}
