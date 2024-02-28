// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_key_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateKeyResult _$CreateKeyResultFromJson(Map<String, dynamic> json) =>
    CreateKeyResult(
      json['name'] as String,
      json['description'] as String,
      $enumDecode(_$EProgressTypeEnumMap, json['type']),
      (json['currentProgress'] as num).toDouble(),
      (json['targetProgress'] as num).toDouble(),
      json['confidenceLevel'] as int,
      json['belongsToOkrSetId'] as int,
    );

Map<String, dynamic> _$CreateKeyResultToJson(CreateKeyResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': _$EProgressTypeEnumMap[instance.type]!,
      'currentProgress': instance.currentProgress,
      'targetProgress': instance.targetProgress,
      'confidenceLevel': instance.confidenceLevel,
      'belongsToOkrSetId': instance.belongsToOkrSetId,
    };

const _$EProgressTypeEnumMap = {
  EProgressType.numeric: 'numeric',
  EProgressType.percentage: 'percentage',
  EProgressType.binary: 'binary',
};
