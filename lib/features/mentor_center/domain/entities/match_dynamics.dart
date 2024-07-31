import 'package:equatable/equatable.dart';
import '../../data/models/match_dynamics_model.dart';

class MatchDynamics extends Equatable {
  const MatchDynamics({
    required this.id,
    required this.title,
    required this.description,
    this.tips,
  });

  final int id;
  final String title;
  final String description;
  final List<String>? tips;

  factory MatchDynamics.fromModel(MatchDynamicsModel model) {
    return MatchDynamics(
      id: model.id,
      title: model.title,
      description: model.description,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        tips,
      ];
}
