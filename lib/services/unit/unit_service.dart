import 'package:epro_frontend/api/apis/unit_api.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/unit_create_dto.dart';
import 'package:epro_frontend/services/unit/i_unit_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IUnitService)
class UnitService with ChangeNotifier implements IUnitService {
  final UnitApi _unitApi;

  UnitService(this._unitApi);

  @override
  Future<List<Unit>> getAllUnits() async {
    return await _unitApi.getAllUnits();
  }

  @override
  Future<void> createUnit(UnitCreateDto unit) async {
    await _unitApi.createUnit(unit);
  }
}