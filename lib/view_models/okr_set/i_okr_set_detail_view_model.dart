import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/model/key_result.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:flutter/cupertino.dart';

abstract class IOkrSetDetailViewModel implements ChangeNotifier {
  ELoadingState get loadingState;

  ELoadingState get loadingStateEdit;

  OkrSet? get okrSet;

  String? get objectiveZiel;
  set objectiveZiel(String? value);

  String? get objectiveBeschreibung;
  set objectiveBeschreibung(String? value);

  OkrSetUnit? get unit;
  set unit(OkrSetUnit? unit);

  int? get paysInto;
  set paysInto(int? value);

  List<KeyResult> get editedKeyResults;
  set editedKeyResults(List<KeyResult> list);

  List<KeyResult> get createdKeyResults;
  set createdKeyResults(List<KeyResult> list);

  Future<void> load(int id);

  Future<void> edit();
}