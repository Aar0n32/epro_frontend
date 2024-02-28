import 'dart:async';

import 'package:epro_frontend/constants/enums/e_error_codes.dart';
import 'package:epro_frontend/constants/enums/e_progress_type.dart';
import 'package:epro_frontend/model/key_result.dart';
import 'package:epro_frontend/model/update_key_result.dart';
import 'package:epro_frontend/services/language/i_language_service.dart';
import 'package:epro_frontend/services/snackbar/i_snack_bar_service.dart';
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
  final ISnackBarService _snackBarService;
  final ILanguageService _languageService;
  final IOkrSetService _okrSetService;

  KeyResultHistoryViewModel(
    this._loggingService,
    this._snackBarService,
    this._languageService,
    this._okrSetService,
  ) : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  String? newValueValidator(String? value, KeyResult keyResult) {
    if (value == null || value.isEmpty) {
      return _languageService.appLocalizations.validationRequired;
    }
    var num = double.tryParse(value);
    if (num == null || num < 0) {
      return _languageService.appLocalizations.validNumber;
    }
    if (num == keyResult.currentProgress) {
      return _languageService.appLocalizations.validOldValue;
    }
    if (num > keyResult.targetProgress) {
      return _languageService.appLocalizations.validTarget;
    }
    if (keyResult.type == EProgressType.binary && num != 0 && num != 1) {
      return _languageService.appLocalizations.validBinary;
    }
    return null;
  }

  @override
  String? commentValidator(String? value) =>
      ValidationBuilder().required().test(value);

  @override
  Future<void> addKeyResultHistory(
    UpdateKeyResult updateKeyResult,
    int okrSetId,
  ) async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('adding key result history');
      notifyListeners();
      await _okrSetService.updateKeyResult(updateKeyResult, okrSetId);
      _loadingState = ELoadingState.done;
      _loggingService.info('adding key result history successful');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error(
          'error while adding key result history', error, stackTrace);
      _loadingState = ELoadingState.error;
      _snackBarService.errorFromCode(error.errorCode);
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error(
          'error while adding key result history', error, stackTrace);
      _loadingState = ELoadingState.error;
      _snackBarService.errorFromCode(ErrorCodes.requestTimeout);
    } catch (error, stackTrace) {
      _loggingService.error(
          'error while adding key result history', error, stackTrace);
      _loadingState = ELoadingState.error;
      _snackBarService.errorFromCode(ErrorCodes.unknownError);
    }
    notifyListeners();
  }
}
