import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:json_annotation/json_annotation.dart';

class RoleJsonConverter implements JsonConverter<ERole, String>{
  const RoleJsonConverter();

  @override fromJson(String json) {
    switch(json){
      case 'CO_OKR_ADMIN':
        return ERole.coOkrAdmin;
      case 'BUO_OKR_ADMIN':
        return ERole.buoOkrAdmin;
      default:
        return ERole.readOnlyUser;
    }
  }

  @override toJson(ERole type) {
    switch(type){
      case ERole.coOkrAdmin:
        return 'CO_OKR_ADMIN';
      case ERole.buoOkrAdmin:
        return 'BUO_OKR_ADMIN';
      case ERole.readOnlyUser:
        return 'READ_ONLY_USER';
    }
  }
}