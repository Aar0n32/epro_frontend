import 'dart:async';

import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/exceptions/okr_api_exception.dart';
import 'package:epro_frontend/model/edit_okr_set.dart';
import 'package:epro_frontend/model/key_result.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/services/logging/i_logging_service.dart';
import 'package:epro_frontend/services/okr_set/i_okr_set_service.dart';
import 'package:epro_frontend/view_models/base_view_model.dart';
import 'package:epro_frontend/view_models/okr_set/i_okr_set_detail_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IOkrSetDetailViewModel)
class OkrSetDetailViewModel extends BaseViewModel
    with ChangeNotifier
    implements IOkrSetDetailViewModel {
  final ILoggingService _loggingService;
  final IOkrSetService _okrSetService;

  OkrSetDetailViewModel(this._loggingService, this._okrSetService)
      : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  ELoadingState _loadingStateEdit = ELoadingState.initial;

  OkrSet? _okrSet;

  String? _objectiveZiel;

  String? _objectiveBeschreibung;

  OkrSetUnit? _unit;

  int? _paysInto;

  List<KeyResult> _editedKeyResults = [];

  List<KeyResult> _createdKeyResults = [];

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  OkrSet? get okrSet => _okrSet;

  @override
  String? get objectiveZiel => _objectiveZiel;

  @override
  set objectiveZiel(String? value) {
    _objectiveZiel = value;
    notifyListeners();
  }

  @override
  String? get objectiveBeschreibung => _objectiveBeschreibung;

  @override
  set objectiveBeschreibung(String? value) {
    _objectiveBeschreibung = value;
    notifyListeners();
  }

  @override
  OkrSetUnit? get unit => _unit;

  @override
  set unit(OkrSetUnit? unit) {
    _unit = unit;
    notifyListeners();
  }

  @override
  int? get paysInto => _paysInto;

  @override
  set paysInto(int? value) {
    _paysInto = value;
    notifyListeners();
  }

  @override
  List<KeyResult> get editedKeyResults => _editedKeyResults;

  @override
  set editedKeyResults(List<KeyResult> list) {
    _editedKeyResults = list;
    notifyListeners();
  }

  @override
  List<KeyResult> get createdKeyResults => _createdKeyResults;

  @override
  set createdKeyResults(List<KeyResult> list) {
    _createdKeyResults = list;
    notifyListeners();
  }

  @override
  Future<void> load(int id) async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('loading okrSet');
      notifyListeners();
      _okrSet = await _okrSetService.getOkrSet(id);
      _loadingState = ELoadingState.done;
      _loggingService.info('loading okrSet successfully');
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
  Future<void> edit() async {
    try {
      _loadingStateEdit = ELoadingState.loading;
      _loggingService.info('editing okr set');
      notifyListeners();
      await _okrSetService.editOkrSet(
        EditOkrSet(
          EditObjectDto(
            _okrSet!.objective.name == _objectiveZiel ? null : _objectiveZiel,
            _okrSet!.objective.description == _objectiveBeschreibung ? null : _objectiveBeschreibung,
          ),
          null,
          null,
          _okrSet!.paysIntoKeyResults?.id == _paysInto ? null : _paysInto,
        ),
        okrSet!.id,
      );
      _loadingStateEdit = ELoadingState.done;
      _loggingService.info('editing okr set successfully');
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
  ELoadingState get loadingStateEdit => _loadingStateEdit;
}
