// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['email'] as String,
      json['firstname'] as String,
      json['lastname'] as String,
      const RoleJsonConverter().fromJson(json['role'] as String),
      json['canEditUnit'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'role': const RoleJsonConverter().toJson(instance.role),
      'canEditUnit': instance.canEditUnit,
    };
