import 'package:flutter/material.dart';

import '../../constants/enums/e_loading_state.dart';

abstract class ILoginViewModel implements ChangeNotifier {
  ELoadingState get loadingState;

  String? get email;

  set email(String? value);

  String? emailValidator(String? value);

  String? get password;

  set password(String? value);

  String? passwordValidator(String? value);

  bool get remember;

  set remember(bool value);

  Future<void> login();
}