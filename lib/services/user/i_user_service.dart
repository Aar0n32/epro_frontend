import 'package:epro_frontend/model/user.dart';
import 'package:epro_frontend/model/user_create_dto.dart';
import 'package:flutter/cupertino.dart';

abstract class IUserService implements ChangeNotifier {
  Future<User?> getMe();

  Future<List<User>> getAllUser();

  Future<void> createUser(UserCreateDto user);
}