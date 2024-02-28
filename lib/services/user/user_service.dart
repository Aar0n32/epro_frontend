import 'package:epro_frontend/api/apis/user_api.dart';
import 'package:epro_frontend/model/user.dart';
import 'package:epro_frontend/model/user_create_dto.dart';
import 'package:epro_frontend/services/user/i_user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IUserService)
class UserService with ChangeNotifier implements IUserService {
  final UserApi _userApi;

  UserService(this._userApi);

  @override
  Future<User?> getMe() async {
    return await _userApi.getMe();
  }

  @override
  Future<List<User>> getAllUser() async {
    return await _userApi.getAllUsers();
  }

  @override
  Future<void> createUser(UserCreateDto user) async {
    await _userApi.createUser(user);
  }
}