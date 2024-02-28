import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'key_result.dart';
import '../../constants/enums/e_unit_type.dart';
import '../../util/json_converter/unit_type_json_converter.dart';

part 'okr_set.g.dart';

@JsonSerializable()
class OkrSet extends Equatable {
  @JsonKey(name: 'okrSetId')
  final int id;
  final OkrSetUnit unit;
  final double progressPercentage;
  final OkrSetObjective objective;
  final List<KeyResult> belongsToKeyResults;
  final KeyResult? paysIntoKeyResults;

  const OkrSet(
    this.id,
    this.unit,
    this.progressPercentage,
    this.objective,
    this.belongsToKeyResults,
    this.paysIntoKeyResults,
  );

  factory OkrSet.fromJson(Map<String, dynamic> json) => _$OkrSetFromJson(json);

  Map<String, dynamic> toJson() => _$OkrSetToJson(this);

  @override
  List<Object?> get props => [
        id,
        unit,
        progressPercentage,
        objective,
        belongsToKeyResults,
        paysIntoKeyResults,
      ];
}

@JsonSerializable()
class OkrSetUnit extends Equatable {
  final int id;
  final String name;
  @UnitTypeJsonConverter()
  final EUnitType type;

  const OkrSetUnit(this.id, this.name, this.type);

  factory OkrSetUnit.fromJson(Map<String, dynamic> json) =>
      _$OkrSetUnitFromJson(json);

  Map<String, dynamic> toJson() => _$OkrSetUnitToJson(this);

  @override
  List<Object?> get props => [id, name, type];
}

@JsonSerializable()
class OkrSetObjective extends Equatable {
  @JsonKey(name: 'objectiveId')
  final int id;
  final String name;
  final String description;

  const OkrSetObjective(this.id, this.name, this.description);

  factory OkrSetObjective.fromJson(Map<String, dynamic> json) =>
      _$OkrSetObjectiveFromJson(json);

  Map<String, dynamic> toJson() => _$OkrSetObjectiveToJson(this);

  @override
  List<Object?> get props => [id, name, description];
}
