import 'package:epro_frontend/constants/enums/e_unit_type.dart';
import 'package:epro_frontend/util/json_converter/children_unit_id_json_converter.dart';
import 'package:epro_frontend/util/json_converter/parent_unit_id_json_converter.dart';
import 'package:epro_frontend/util/json_converter/unit_type_json_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit extends Equatable {
  final int id;
  @JsonKey(name: 'unitName')
  final String name;
  @JsonKey(name: 'unitType')
  @UnitTypeJsonConverter()
  final EUnitType type;
  @JsonKey(name: 'parentUnit')
  @ParentUnitIdJsonConverter()
  final int? parentId;
  @JsonKey(name: 'childUnits')
  @ChildrenUnitIdJsonConverter()
  final List<int> childIds;

  const Unit(this.id, this.name, this.type, this.parentId, this.childIds);

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  @override
  List<Object?> get props => [id, name, type, parentId, childIds];
}