// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_okr_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditOkrSet _$EditOkrSetFromJson(Map<String, dynamic> json) => EditOkrSet(
      EditObjectDto.fromJson(json['editObjectiveDto'] as Map<String, dynamic>),
      (json['editKeyResultDtoList'] as List<dynamic>?)
          ?.map((e) => EditKeyResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['createKeyResultDtoList'] as List<dynamic>?)
          ?.map((e) => CreateKeyResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['paysIntoNewKeyResultId'] as int?,
    );

Map<String, dynamic> _$EditOkrSetToJson(EditOkrSet instance) =>
    <String, dynamic>{
      'editObjectiveDto': instance.editObjectiveDto,
      'editKeyResultDtoList': instance.editKeyResultDtoList,
      'createKeyResultDtoList': instance.createKeyResultDtoList,
      'paysIntoNewKeyResultId': instance.paysIntoNewKeyResultId,
    };

EditObjectDto _$EditObjectDtoFromJson(Map<String, dynamic> json) =>
    EditObjectDto(
      json['name'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$EditObjectDtoToJson(EditObjectDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

EditKeyResultDto _$EditKeyResultDtoFromJson(Map<String, dynamic> json) =>
    EditKeyResultDto(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      (json['newTargetProgress'] as num).toDouble(),
      (json['newConfidenceLevel'] as num).toDouble(),
    );

Map<String, dynamic> _$EditKeyResultDtoToJson(EditKeyResultDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'newTargetProgress': instance.newTargetProgress,
      'newConfidenceLevel': instance.newConfidenceLevel,
    };
