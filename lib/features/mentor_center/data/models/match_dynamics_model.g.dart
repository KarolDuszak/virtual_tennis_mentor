// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_dynamics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchDynamicsModel _$MatchDynamicsModelFromJson(Map<String, dynamic> json) =>
    MatchDynamicsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MatchDynamicsModelToJson(MatchDynamicsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
