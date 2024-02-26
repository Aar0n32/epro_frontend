// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'okr_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OkrSet _$OkrSetFromJson(Map<String, dynamic> json) => OkrSet(
      json['id'] as int,
      OkrSetUnit.fromJson(json['unit'] as Map<String, dynamic>),
      OkrSetObjective.fromJson(json['objective'] as Map<String, dynamic>),
      (json['belongsToKeyResults'] as List<dynamic>)
          .map((e) => KeyResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OkrSetToJson(OkrSet instance) => <String, dynamic>{
      'id': instance.id,
      'unit': instance.unit,
      'objective': instance.objective,
      'belongsToKeyResults': instance.belongsToKeyResults,
    };

OkrSetUnit _$OkrSetUnitFromJson(Map<String, dynamic> json) => OkrSetUnit(
      json['id'] as int,
      json['name'] as String,
      const UnitTypeJsonConverter().fromJson(json['type'] as String),
    );

Map<String, dynamic> _$OkrSetUnitToJson(OkrSetUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': const UnitTypeJsonConverter().toJson(instance.type),
    };

OkrSetObjective _$OkrSetObjectiveFromJson(Map<String, dynamic> json) =>
    OkrSetObjective(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$OkrSetObjectiveToJson(OkrSetObjective instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
