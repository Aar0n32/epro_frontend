// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      json['id'] as int,
      json['unitName'] as String,
      const UnitTypeJsonConverter().fromJson(json['unitType'] as String),
      _$JsonConverterFromJson<Map<String, dynamic>, int?>(
          json['parentUnit'], const ParentUnitIdJsonConverter().fromJson),
      const ChildrenUnitIdJsonConverter().fromJson(json['childUnits'] as List?),
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'id': instance.id,
      'unitName': instance.name,
      'unitType': const UnitTypeJsonConverter().toJson(instance.type),
      'parentUnit': const ParentUnitIdJsonConverter().toJson(instance.parentId),
      'childUnits':
          const ChildrenUnitIdJsonConverter().toJson(instance.childIds),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
