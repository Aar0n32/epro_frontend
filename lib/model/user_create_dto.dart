import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:epro_frontend/util/json_converter/role_json_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_create_dto.g.dart';

@JsonSerializable()
class UserCreateDto extends Equatable {
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  @RoleJsonConverter()
  final ERole role;
  final int? unitId;

  const UserCreateDto(this.email, this.password, this.firstname, this.lastname,
      this.role, this.unitId);

  factory UserCreateDto.fromJson(Map<String, dynamic> json) =>
      _$UserCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateDtoToJson(this);

  @override
  List<Object?> get props =>
      [email, password, firstname, lastname, role, unitId];
}
