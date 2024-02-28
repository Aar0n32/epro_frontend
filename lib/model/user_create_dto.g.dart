// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateDto _$UserCreateDtoFromJson(Map<String, dynamic> json) =>
    UserCreateDto(
      json['email'] as String,
      json['password'] as String,
      json['firstname'] as String,
      json['lastname'] as String,
      const RoleJsonConverter().fromJson(json['role'] as String),
      json['unitId'] as int?,
    );

Map<String, dynamic> _$UserCreateDtoToJson(UserCreateDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'role': const RoleJsonConverter().toJson(instance.role),
      'unitId': instance.unitId,
    };
