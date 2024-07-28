import 'package:equatable/equatable.dart';

class MatchDynamics extends Equatable{
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
  
  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    description,
    tips,
  ];
}