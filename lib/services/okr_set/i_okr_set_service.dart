import 'package:flutter/cupertino.dart';

import '../../model/okr_set.dart';

abstract class IOkrSetService implements ChangeNotifier {
  Future<List<OkrSet>> getAllOkrSets();
}