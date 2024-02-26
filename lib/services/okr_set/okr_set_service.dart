import 'package:epro_frontend/api/apis/okr_set_api.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/services/okr_set/i_okr_set_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IOkrSetService)
class OkrSetService with ChangeNotifier implements IOkrSetService {
  final OkrSetAPi _okrSetAPi;

  OkrSetService(this._okrSetAPi);

  @override
  Future<List<OkrSet>> getAllOkrSets() async {
    return await _okrSetAPi.getAllOkrSets();
  }
}