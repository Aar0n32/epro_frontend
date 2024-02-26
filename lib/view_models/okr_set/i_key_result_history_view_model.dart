import 'package:flutter/cupertino.dart';

import '../../constants/enums/e_loading_state.dart';

abstract class IKeyResultHistoryViewModel extends ChangeNotifier {
  ELoadingState get loadingState;

  String? newValueValidator(String? value);

  String? commentValidator(String? value);

  Future<void> addKeyResultHistory(int keyResultId, double value, String comment);
}