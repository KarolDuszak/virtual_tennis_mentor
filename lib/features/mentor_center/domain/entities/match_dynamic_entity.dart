import 'package:equatable/equatable.dart';

class MatchDynamicEntity extends Equatable{
  const MatchDynamicEntity({
    required this.title,
    required this.description,
    this.tips,
  });

  final String title;
  final String description;
  final List<String>? tips;
  
  @override
  List<Object?> get props => <Object?>[
    title,
    description,
    tips,
  ];
}