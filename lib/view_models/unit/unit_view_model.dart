import 'dart:async';

import 'package:epro_frontend/constants/enums/e_error_codes.dart';
import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_unit_type.dart';
import 'package:epro_frontend/exceptions/okr_api_exception.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/unit_create_dto.dart';
import 'package:epro_frontend/services/logging/i_logging_service.dart';
import 'package:epro_frontend/services/snackbar/i_snack_bar_service.dart';
import 'package:epro_frontend/services/unit/i_unit_service.dart';
import 'package:epro_frontend/view_models/base_view_model.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IUnitViewModel)
class UnitViewModel extends BaseViewModel
    with ChangeNotifier
    implements IUnitViewModel {
  final ILoggingService _loggingService;
  final ISnackBarService _snackBarService;
  final IUnitService _unitService;

  UnitViewModel(this._loggingService, this._snackBarService, this._unitService)
      : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  ELoadingState _loadingStateCreate = ELoadingState.initial;

  List<Unit> _units = [];

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  ELoadingState get loadingStateCreate => _loadingStateCreate;

  @override
  String? nameValidator(String? value) =>
      ValidationBuilder().required().test(value);

  @override
  Unit get companyUnit =>
      _units.firstWhere((unit) => unit.type == EUnitType.company);

  @override
  List<Unit> get units => _units;

  @override
  List<Unit> getChildUnits(int id) =>
      _units.where((element) => element.parentId == id).toList();

  @override
  Future<void> load() async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('loading units');
      notifyListeners();
      _units = await _unitService.getAllUnits();
      _loadingState = ELoadingState.done;
      _loggingService.info('loading units succesfull');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error('error while loading units', error, stackTrace);
      _loadingState = ELoadingState.error;
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error('error while loading units', error, stackTrace);
      _loadingState = ELoadingState.error;
    } catch (error, stackTrace) {
      _loggingService.error('error while loading units', error, stackTrace);
      _loadingState = ELoadingState.error;
    }
    notifyListeners();
  }

  @override
  Future<void> createUnit(UnitCreateDto unit) async {
    try {
      _loadingStateCreate = ELoadingState.loading;
      _loggingService.info('adding unit');
      notifyListeners();
      await _unitService.createUnit(unit);
      _loadingStateCreate = ELoadingState.done;
      _loggingService.info('adding unit successful');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error('error while adding unit', error, stackTrace);
      _loadingStateCreate = ELoadingState.error;
      _snackBarService.errorFromCode(error.errorCode);
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error('error while adding unit', error, stackTrace);
      _loadingStateCreate = ELoadingState.error;
      _snackBarService.errorFromCode(ErrorCodes.requestTimeout);
    } catch (error, stackTrace) {
      _loggingService.error('error while adding unit', error, stackTrace);
      _loadingStateCreate = ELoadingState.error;
      _snackBarService.errorFromCode(ErrorCodes.unknownError);
    }
    notifyListeners();
  }
}
