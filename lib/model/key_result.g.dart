// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyResult _$KeyResultFromJson(Map<String, dynamic> json) => KeyResult(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      (json['currentProgress'] as num).toDouble(),
      (json['targetProgress'] as num).toDouble(),
      const ProgressTypeJsonConverter().fromJson(json['type'] as String),
      json['okrSetId'] as int,
      (json['keyResultHistoryEntry'] as List<dynamic>)
          .map((e) => KeyResultHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KeyResultToJson(KeyResult instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'currentProgress': instance.currentProgress,
      'targetProgress': instance.targetProgress,
      'type': const ProgressTypeJsonConverter().toJson(instance.type),
      'okrSetId': instance.okrSetId,
      'keyResultHistoryEntry': instance.keyResultHistoryEntry,
    };
