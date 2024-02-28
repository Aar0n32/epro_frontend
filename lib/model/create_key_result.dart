import 'package:epro_frontend/constants/enums/e_progress_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_key_result.g.dart';

@JsonSerializable()
class CreateKeyResult extends Equatable {
  final String name;
  final String description;
  final EProgressType type;
  final double currentProgress;
  final double targetProgress;
  final int confidenceLevel;
  final int belongsToOkrSetId;

  const CreateKeyResult(
    this.name,
    this.description,
    this.type,
    this.currentProgress,
    this.targetProgress,
    this.confidenceLevel,
    this.belongsToOkrSetId,
  );

  factory CreateKeyResult.fromJson(Map<String, dynamic> json) =>
      _$CreateKeyResultFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKeyResultToJson(this);

  @override
  List<Object?> get props => [
        name,
        description,
        type,
        currentProgress,
        targetProgress,
        confidenceLevel,
        belongsToOkrSetId,
      ];
}
