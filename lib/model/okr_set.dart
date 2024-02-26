import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'key_result.dart';
import '../../constants/enums/e_unit_type.dart';
import '../../util/json_converter/unit_type_json_converter.dart';

part 'okr_set.g.dart';

@JsonSerializable()
class OkrSet extends Equatable {
  final int id;
  final OkrSetUnit unit;
  final OkrSetObjective objective;
  final List<KeyResult> belongsToKeyResults;

  const OkrSet(this.id, this.unit, this.objective, this.belongsToKeyResults);

  factory OkrSet.fromJson(Map<String, dynamic> json) => _$OkrSetFromJson(json);

  Map<String, dynamic> toJson() => _$OkrSetToJson(this);

  @override
  List<Object?> get props => [id, unit, objective, belongsToKeyResults];
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
