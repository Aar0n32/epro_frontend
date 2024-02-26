import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'key_result_history.dart';
import '../constants/enums/e_progress_type.dart';
import '../util/json_converter/progress_type_json_converter.dart';

part 'key_result.g.dart';

@JsonSerializable()
class KeyResult extends Equatable {
  final int id;
  final String name;
  final String description;
  final double currentProgress;
  final double targetProgress;
  @ProgressTypeJsonConverter()
  final EProgressType type;
  final int okrSetId;
  final List<KeyResultHistory> keyResultHistoryEntry;

  const KeyResult(this.id, this.name, this.description, this.currentProgress, this.targetProgress, this.type, this.okrSetId, this.keyResultHistoryEntry);

  factory KeyResult.fromJson(Map<String, dynamic> json) => _$KeyResultFromJson(json);

  Map<String, dynamic> toJson() => _$KeyResultToJson(this);

  @override
  List<Object?> get props => [id, name, description, currentProgress, targetProgress, type, okrSetId, keyResultHistoryEntry];
}