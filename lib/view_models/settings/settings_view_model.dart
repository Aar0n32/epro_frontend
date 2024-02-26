import 'dart:async';

import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/route_names.dart';
import 'package:epro_frontend/exceptions/okr_api_exception.dart';
import 'package:epro_frontend/services/auth/i_auth_service.dart';
import 'package:epro_frontend/services/logging/i_logging_service.dart';
import 'package:epro_frontend/services/router/i_router_service.dart';
import 'package:epro_frontend/view_models/base_view_model.dart';
import 'package:epro_frontend/view_models/settings/i_settings_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ISettingsViewModel)
class SettingsViewModel extends BaseViewModel
    with ChangeNotifier
    implements ISettingsViewModel {
  final ILoggingService _loggingService;
  final IRouterService _routerService;
  final IAuthService _authService;

  SettingsViewModel(
      this._loggingService, this._routerService, this._authService)
      : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  Future<void> logout() async {
    try{
      _loadingState = ELoadingState.loading;
      _loggingService.info('logging out');
      notifyListeners();
      await _authService.logout();
      _loadingState = ELoadingState.done;
      _loggingService.info('logging out successful');
    }on OkrApiException catch (error, stackTrace){
      _loggingService.error('error while logging out 1', error, stackTrace);
      _loadingState = ELoadingState.error;
    } on TimeoutException catch (error, stackTrace){
      _loggingService.error('error while logging out 2', error, stackTrace);
      _loadingState = ELoadingState.error;
    } catch (error, stackTrace){
      _loggingService.error('error while logging out 3', error, stackTrace);
      _loadingState = ELoadingState.error;
    }
    _routerService.goNamed(RouteNames.login);
    notifyListeners();
  }
}
