import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/unit_create_dto.dart';
import 'package:flutter/cupertino.dart';

abstract class IUnitService implements ChangeNotifier{
  Future<List<Unit>> getAllUnits();

  Future<void> createUnit(UnitCreateDto unit);
}