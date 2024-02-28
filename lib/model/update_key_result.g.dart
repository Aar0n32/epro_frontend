// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_key_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateKeyResult _$UpdateKeyResultFromJson(Map<String, dynamic> json) =>
    UpdateKeyResult(
      json['id'] as int,
      (json['newProgress'] as num).toDouble(),
      json['comment'] as String,
      const ProgressTypeJsonConverter().fromJson(json['type'] as String),
    );

Map<String, dynamic> _$UpdateKeyResultToJson(UpdateKeyResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'newProgress': instance.newProgress,
      'comment': instance.comment,
      'type': const ProgressTypeJsonConverter().toJson(instance.type),
    };
