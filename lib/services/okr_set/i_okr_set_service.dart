import 'package:epro_frontend/model/update_key_result.dart';
import 'package:flutter/cupertino.dart';

import '../../model/okr_set.dart';

abstract class IOkrSetService implements ChangeNotifier {
  Future<List<OkrSet>> getAllOkrSets();

  Future<void> updateKeyResult(UpdateKeyResult updateKeyResult, int okrSetId);
}