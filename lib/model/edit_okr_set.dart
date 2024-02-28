import 'package:epro_frontend/model/create_key_result.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_okr_set.g.dart';

@JsonSerializable()
class EditOkrSet extends Equatable {
  final EditObjectDto editObjectiveDto;
  final List<EditKeyResultDto>? editKeyResultDtoList;
  final List<CreateKeyResult>? createKeyResultDtoList;
  final int? paysIntoNewKeyResultId;

  const EditOkrSet(
    this.editObjectiveDto,
    this.editKeyResultDtoList,
    this.createKeyResultDtoList,
    this.paysIntoNewKeyResultId,
  );

  factory EditOkrSet.fromJson(Map<String, dynamic> json) =>
      _$EditOkrSetFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EditOkrSetToJson(this);

  @override
  List<Object?> get props => [
        editObjectiveDto,
        editKeyResultDtoList,
        createKeyResultDtoList,
        paysIntoNewKeyResultId,
      ];
}

@JsonSerializable()
class EditObjectDto extends Equatable {
  final String? name;
  final String? description;

  const EditObjectDto(this.name, this.description);

  factory EditObjectDto.fromJson(Map<String, dynamic> json) =>
      _$EditObjectDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EditObjectDtoToJson(this);

  @override
  List<Object?> get props => [name, description];
}

@JsonSerializable()
class EditKeyResultDto extends Equatable {
  final int id;
  final String name;
  final String description;
  final double newTargetProgress;
  final double newConfidenceLevel;

  const EditKeyResultDto(
    this.id,
    this.name,
    this.description,
    this.newTargetProgress,
    this.newConfidenceLevel,
  );

  factory EditKeyResultDto.fromJson(Map<String, dynamic> json) =>
      _$EditKeyResultDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EditKeyResultDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        newTargetProgress,
        newConfidenceLevel,
      ];
}
