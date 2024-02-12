import 'package:flutter/cupertino.dart';
import '../i_initializable.dart';

abstract class IAuthService implements ChangeNotifier, Initializable {
  bool get isAuthenticated;

  String get token;

  List<String> get authentication;
}