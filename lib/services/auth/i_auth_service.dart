import 'package:flutter/cupertino.dart';

import '../i_initializable.dart';
import '../../model/login_dto.dart';

abstract class IAuthService implements ChangeNotifier, Initializable {
  bool get isAuthenticated;

  String? get token;

  List<String> get authentication;

  Future<void> login(LoginDto loginDto, bool remember);

  Future<void> logout();
}