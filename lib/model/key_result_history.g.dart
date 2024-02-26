// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_result_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyResultHistory _$KeyResultHistoryFromJson(Map<String, dynamic> json) =>
    KeyResultHistory(
      json['id'] as int,
      (json['progress'] as num).toDouble(),
      json['comment'] as String,
      DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$KeyResultHistoryToJson(KeyResultHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'progress': instance.progress,
      'comment': instance.comment,
      'date': instance.date.toIso8601String(),
    };
