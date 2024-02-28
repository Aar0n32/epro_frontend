import 'package:epro_frontend/model/key_result.dart';
import 'package:epro_frontend/model/update_key_result.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/enums/e_loading_state.dart';

abstract class IKeyResultHistoryViewModel extends ChangeNotifier {
  ELoadingState get loadingState;

  String? newValueValidator(String? value, KeyResult keyResult);

  String? commentValidator(String? value);

  Future<void> addKeyResultHistory(
    UpdateKeyResult updateKeyResult,
    int okrSetId,
  );
}
