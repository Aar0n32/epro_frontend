import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:injectable/injectable.dart';

import 'i_key_result_history_view_model.dart';
import '../base_view_model.dart';
import '../../constants/enums/e_loading_state.dart';
import '../../exceptions/okr_api_exception.dart';
import '../../services/logging/i_logging_service.dart';
import '../../services/okr_set/i_okr_set_service.dart';

@Singleton(as: IKeyResultHistoryViewModel)
class KeyResultHistoryViewModel extends BaseViewModel
    with ChangeNotifier
    implements IKeyResultHistoryViewModel {
  final ILoggingService _loggingService;
  final IOkrSetService _okrSetService;

  KeyResultHistoryViewModel(this._loggingService, this._okrSetService)
      : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  String? newValueValidator(String? value) {
    // TODO: Test, max number depending on type
    if (value == null || value.isEmpty) return 'Feld nötig';
    var num = double.tryParse(value);
    if (num == null) return 'Keine Nummer';
    if (num < 0) return 'Positive Nummer';
    return null;
  }

  @override
  String? commentValidator(String? value) =>
      ValidationBuilder().required().test(value);

  @override
  Future<void> addKeyResultHistory(
    int keyResultId,
    double value,
    String comment,
  ) async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('adding key result history');
      notifyListeners();
      // await _okrSetService.add TODO: add method
      _loadingState = ELoadingState.done;
      _loggingService.info('adding key result history successful');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error(
          'error while adding key result history', error, stackTrace);
      _loadingState = ELoadingState.error;
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error(
          'error while adding key result history', error, stackTrace);
      _loadingState = ELoadingState.error;
    } catch (error, stackTrace) {
      _loggingService.error(
          'error while adding key result history', error, stackTrace);
      _loadingState = ELoadingState.error;
    }
    notifyListeners();
  }
}
