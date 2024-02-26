import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:injectable/injectable.dart';

import 'i_login_view_model.dart';
import '../base_view_model.dart';
import '../../constants/enums/e_error_codes.dart';
import '../../constants/enums/e_loading_state.dart';
import '../../constants/route_names.dart';
import '../../exceptions/okr_api_exception.dart';
import '../../model/login_dto.dart';
import '../../services/auth/i_auth_service.dart';
import '../../services/language/i_language_service.dart';
import '../../services/logging/i_logging_service.dart';
import '../../services/router/i_router_service.dart';
import '../../services/snackbar/i_snack_bar_service.dart';

@Singleton(as: ILoginViewModel)
class LoginViewModel extends BaseViewModel with ChangeNotifier implements ILoginViewModel {
  final IAuthService _authService;
  final IRouterService _routerService;
  final ILanguageService _languageService;
  final ISnackBarService _snackBarService;
  final ILoggingService _loggingService;

  LoginViewModel(this._authService, this._routerService, this._languageService, this._snackBarService, this._loggingService):super(_loggingService);

  String? _email;

  String? _password;

  @override
  bool remember = false;

  ELoadingState _loadingState = ELoadingState.initial;

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  Future<void> login() async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('login start...');
      notifyListeners();
      await _authService.login(LoginDto(_email!, _password!), remember);
      _loadingState = ELoadingState.done;
      _loggingService.info('login succsessful');
      _routerService.goNamed(RouteNames.dashboard);
    } on OkrApiException catch (error, stackTrace){
      _loggingService.error('error while login', error, stackTrace);
      _loadingState = ELoadingState.error;
      _handleLoginError(error.errorCode);
    } on TimeoutException catch (error, stackTrace){
      _loggingService.error('error while login', error, stackTrace);
      _loadingState = ELoadingState.error;
      _handleLoginError(ErrorCodes.requestTimeout);
    } catch (error, stackTrace){
      _loggingService.error('error while login', error, stackTrace);
      _loadingState = ELoadingState.error;
      _handleLoginError();
    }
    notifyListeners();
  }

  @override
  String? get email => _email;

  @override
  set email(String? value){
    _email = value;
    notifyListeners();
  }

  @override
  String? emailValidator(String? value) => ValidationBuilder().required().email().test(value);

  @override
  String? get password => _password;

  @override
  set password(String? value){
    _password = value;
    notifyListeners();
  }

  @override
  String? passwordValidator(String? value) => ValidationBuilder().required().test(value);

  void _handleLoginError([ErrorCodes? errorCode]){
    String message;

    switch(errorCode){
      case ErrorCodes.unauthorizedUser:
      case ErrorCodes.forbiddenAction:
        message = _languageService.appLocalizations.errorLoginNachricht;
        break;
      case
        ErrorCodes.requestTimeout:
      case ErrorCodes.noInternetConnection:
      case ErrorCodes.serverNotAvailable:
        message = _languageService.appLocalizations.errorServerNachricht;
        break;
      default:
        message = _languageService.appLocalizations.errorStandardNachricht;
    }

    _snackBarService.error(message);
  }
}