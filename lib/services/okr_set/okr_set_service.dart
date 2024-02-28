import 'package:epro_frontend/api/apis/okr_set_api.dart';
import 'package:epro_frontend/model/edit_okr_set.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/model/update_key_result.dart';
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

  @override
  Future<OkrSet?> getOkrSet(int id) async {
    return await _okrSetAPi.getOkrSet(id);
  }

  @override
  Future<void> updateKeyResult(
    UpdateKeyResult updateKeyResult,
    int okrSetId,
  ) async {
    await _okrSetAPi.updateKeyResult(updateKeyResult, okrSetId);
  }

  @override
  Future<void> editOkrSet(EditOkrSet okrSet, int id)  async{
    await _okrSetAPi.editOkrSet(okrSet, id);
  }
}
