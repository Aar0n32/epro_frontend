import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:epro_frontend/util/json_converter/role_json_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  @RoleJsonConverter()
  final ERole role;
  final int? canEditUnit;

  const User(this.id, this.email, this.firstname, this.lastname, this.role,
      this.canEditUnit);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props =>
      [id, email, firstname, lastname, role, canEditUnit];
}
