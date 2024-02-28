import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/user.dart';
import 'package:flutter/cupertino.dart';

abstract class IUserViewModel implements ChangeNotifier {
  ELoadingState get loadingState;

  ELoadingState get loadingStateMe;

  ELoadingState get loadingStateAdd;

  String? get dialogFirstname;

  set dialogFirstname(String? value);

  String? get dialogLastname;

  set dialogLastname(String? value);

  String? get dialogMail;

  set dialogMail(String? value);

  String? get dialogPassword;

  set dialogPassword(String? value);

  ERole get dialogRole;

  set dialogRole(ERole role);

  Unit? get dialogUnit;

  set dialogUnit(Unit? unit);

  String? nameValidator(String? value);

  String? mailValidator(String? value);

  String? passwordValidator(String? value);

  String? unitValidator(Unit? unit);

  User? get me;

  List<User> get user;

  Future<void> loadMe();

  Future<void> load();

  Future<void> createUser();
}