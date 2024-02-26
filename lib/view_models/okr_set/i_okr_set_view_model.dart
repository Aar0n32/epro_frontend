import 'package:flutter/cupertino.dart';

import '../../constants/enums/e_loading_state.dart';
import '../../model/okr_set.dart';

abstract class IOkrSetViewModel implements ChangeNotifier {
  ELoadingState get loadingState;

  List<OkrSet> get okrSets;

  Future<void> load();

  Future<void> addOkrSet();
}