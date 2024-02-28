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
  final double progressPercentage;
  final int confidenceLevel;
  @ProgressTypeJsonConverter()
  final EProgressType type;
  @JsonKey(name: 'belongsToOkrSet')
  final int okrSetId;
  final List<int> okrSetsThatPayIntoThisKeyResult;
  final List<KeyResultHistory>? keyResultHistory;

  const KeyResult(
    this.id,
    this.name,
    this.description,
    this.currentProgress,
    this.targetProgress,
    this.progressPercentage,
    this.confidenceLevel,
    this.type,
    this.okrSetId,
    this.okrSetsThatPayIntoThisKeyResult,
    this.keyResultHistory,
  );

  factory KeyResult.fromJson(Map<String, dynamic> json) =>
      _$KeyResultFromJson(json);

  Map<String, dynamic> toJson() => _$KeyResultToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        currentProgress,
        targetProgress,
        progressPercentage,
        confidenceLevel,
        type,
        okrSetId,
        okrSetsThatPayIntoThisKeyResult,
        keyResultHistory,
      ];
}
