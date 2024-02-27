import 'package:epro_frontend/constants/enums/e_error_codes.dart';
import 'package:flutter/material.dart';

abstract class ISnackBarService implements ChangeNotifier {
  GlobalKey<ScaffoldMessengerState> get messangerKey;

  void error(String text);

  void warning(String text);

  void success(String text);

  void info(String text);

  void errorFromCode(ErrorCodes errorCode);
}
