import 'package:epro_frontend/constants/enums/e_unit_type.dart';
import 'package:epro_frontend/util/json_converter/unit_type_json_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_create_dto.g.dart';

@JsonSerializable()
class UnitCreateDto extends Equatable {
  @JsonKey(name: 'unitName')
  final String name;
  @JsonKey(name: 'unitType')
  @UnitTypeJsonConverter()
  final EUnitType type;
  final int? parentUnitId;

  const UnitCreateDto(this.name, this.type, this.parentUnitId);

  factory UnitCreateDto.fromJson(Map<String, dynamic> json) => _$UnitCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UnitCreateDtoToJson(this);

  @override
  List<Object?> get props => [name, type, parentUnitId];
}