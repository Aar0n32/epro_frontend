import 'dart:async';

import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/exceptions/okr_api_exception.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/services/logging/i_logging_service.dart';
import 'package:epro_frontend/services/okr_set/i_okr_set_service.dart';
import 'package:epro_frontend/view_models/base_view_model.dart';
import 'package:epro_frontend/view_models/okr_set/i_okr_set_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IOkrSetViewModel)
class OkrSetViewModel extends BaseViewModel
    with ChangeNotifier
    implements IOkrSetViewModel {
  final ILoggingService _loggingService;
  final IOkrSetService _okrSetService;

  OkrSetViewModel(this._loggingService, this._okrSetService)
      : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  List<OkrSet> _okrSets = [];

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  List<OkrSet> get okrSets => _okrSets;

  @override
  Future<void> load() async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('loading okr sets');
      notifyListeners();
      _okrSets = await _okrSetService.getAllOkrSets();
      _loadingState = ELoadingState.done;
      _loggingService.info('loading okr sets successful');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error('error while loading okr sets', error, stackTrace);
      _loadingState = ELoadingState.error;
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error('error while loading okr sets', error, stackTrace);
      _loadingState = ELoadingState.error;
    } catch (error, stackTrace) {
      _loggingService.error('error while loading okr sets', error, stackTrace);
      _loadingState = ELoadingState.error;
    }
    notifyListeners();
  }

  @override
  Future<void> addOkrSet() {
    // TODO: implement addOkrSet
    throw UnimplementedError();
  }
}
