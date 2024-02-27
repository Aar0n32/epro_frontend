// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitCreateDto _$UnitCreateDtoFromJson(Map<String, dynamic> json) =>
    UnitCreateDto(
      json['unitName'] as String,
      const UnitTypeJsonConverter().fromJson(json['unitType'] as String),
      json['parentUnitId'] as int?,
    );

Map<String, dynamic> _$UnitCreateDtoToJson(UnitCreateDto instance) =>
    <String, dynamic>{
      'unitName': instance.name,
      'unitType': const UnitTypeJsonConverter().toJson(instance.type),
      'parentUnitId': instance.parentUnitId,
    };
