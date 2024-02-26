import 'package:epro_frontend/constants/enums/e_unit_type.dart';
import 'package:json_annotation/json_annotation.dart';

class UnitTypeJsonConverter implements JsonConverter<EUnitType, String> {
  const UnitTypeJsonConverter();

  @override fromJson(String json) {
    switch(json){
      case 'COMPANY':
        return EUnitType.company;
      case 'BUSINESS_UNIT':
        return EUnitType.businessUnit;
      default:
        return EUnitType.unit;
    }
  }

  @override toJson(EUnitType type) {
    switch(type){
      case EUnitType.company:
        return 'COMPANY';
      case EUnitType.businessUnit:
        return 'BUSINESS_UNIT';
      case EUnitType.unit:
        return 'UNIT';
    }
  }
}