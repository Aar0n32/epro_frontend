import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:flutter/cupertino.dart';

abstract class ISettingsViewModel implements ChangeNotifier {
  ELoadingState get loadingState;

  Future<void> logout();
}