import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/unit_create_dto.dart';
import 'package:flutter/cupertino.dart';

abstract class IUnitViewModel implements ChangeNotifier {
  ELoadingState get loadingState;

  ELoadingState get loadingStateCreate;

  String? nameValidator(String? value);

  Unit get companyUnit;

  List<Unit> get units;

  List<Unit> getChildUnits(int id);

  Future<void> load();

  Future<void> createUnit(UnitCreateDto unit);
}