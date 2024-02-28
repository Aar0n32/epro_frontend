import 'dart:async';

import 'package:epro_frontend/constants/enums/e_error_codes.dart';
import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:epro_frontend/exceptions/okr_api_exception.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/user.dart';
import 'package:epro_frontend/model/user_create_dto.dart';
import 'package:epro_frontend/services/logging/i_logging_service.dart';
import 'package:epro_frontend/services/snackbar/i_snack_bar_service.dart';
import 'package:epro_frontend/services/user/i_user_service.dart';
import 'package:epro_frontend/view_models/base_view_model.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IUserViewModel)
class UserViewModel extends BaseViewModel
    with ChangeNotifier
    implements IUserViewModel {
  final ILoggingService _loggingService;
  final ISnackBarService _snackBarService;
  final IUserService _userService;

  UserViewModel(this._loggingService, this._snackBarService, this._userService)
      : super(_loggingService);

  ELoadingState _loadingState = ELoadingState.initial;

  ELoadingState _loadingStateMe = ELoadingState.initial;

  ELoadingState _loadingStateAdd = ELoadingState.initial;

  String? _dialogFirstname;

  String? _dialogLastname;

  String? _dialogMail;

  String? _dialogPassword;

  ERole _dialogRole = ERole.readOnlyUser;

  Unit? _dialogUnit;

  User? _me;

  List<User> _user = [];

  @override
  ELoadingState get loadingState => _loadingState;

  @override
  ELoadingState get loadingStateMe => _loadingStateMe;

  @override
  ELoadingState get loadingStateAdd => _loadingStateAdd;

  @override
  String? get dialogFirstname => _dialogFirstname;

  @override
  set dialogFirstname(String? value) {
    _dialogFirstname = value;
    notifyListeners();
  }

  @override
  String? get dialogLastname => _dialogLastname;

  @override
  set dialogLastname(String? value) {
    _dialogLastname = value;
    notifyListeners();
  }

  @override
  String? get dialogMail => _dialogMail;

  @override
  set dialogMail(String? value) {
    _dialogMail = value;
    notifyListeners();
  }

  @override
  String? get dialogPassword => _dialogPassword;

  @override
  set dialogPassword(String? value) {
    _dialogPassword = value;
    notifyListeners();
  }

  @override
  ERole get dialogRole => _dialogRole;

  @override
  set dialogRole(ERole role) {
    _dialogRole = role;
    notifyListeners();
  }

  @override
  Unit? get dialogUnit => _dialogUnit;

  @override
  set dialogUnit(Unit? unit) {
    _dialogUnit = unit;
    notifyListeners();
  }

  @override
  String? nameValidator(String? value) =>
      ValidationBuilder().required().test(value);

  @override
  String? mailValidator(String? value) =>
      ValidationBuilder().required().email().test(value);

  @override
  String? passwordValidator(String? value) =>
      ValidationBuilder().required().minLength(6).test(value);

  @override
  String? unitValidator(Unit? unit) {
    if (_dialogRole == ERole.buoOkrAdmin && unit == null) {
      return 'Bu-Admins muss eine Unit zugewiesen werden';
    }
    if (_dialogRole != ERole.buoOkrAdmin && unit != null) {
      return 'Nur Bu-Admins kann eine Unit zugewieden werden';
    }
    return null;
  }

  @override
  User? get me => _me;

  @override
  List<User> get user => _user;

  @override
  Future<void> loadMe() async {
    try {
      _loadingStateMe = ELoadingState.loading;
      _loggingService.info('loading me');
      notifyListeners();
      _me = await _userService.getMe();
      _loadingStateMe = ELoadingState.done;
      _loggingService.info('loading me succesfull');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error('error while loading me', error, stackTrace);
      _loadingStateMe = ELoadingState.error;
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error('error while loading me', error, stackTrace);
      _loadingStateMe = ELoadingState.error;
    } catch (error, stackTrace) {
      _loggingService.error('error while loading me', error, stackTrace);
      _loadingStateMe = ELoadingState.error;
    }
    notifyListeners();
  }

  @override
  Future<void> load() async {
    try {
      _loadingState = ELoadingState.loading;
      _loggingService.info('loading users');
      notifyListeners();
      _user = await _userService.getAllUser();
      _loadingState = ELoadingState.done;
      _loggingService.info('loading users succesfull');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error('error while loading users', error, stackTrace);
      _loadingState = ELoadingState.error;
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error('error while loading users', error, stackTrace);
      _loadingState = ELoadingState.error;
    } catch (error, stackTrace) {
      _loggingService.error('error while loading users', error, stackTrace);
      _loadingState = ELoadingState.error;
    }
    notifyListeners();
  }

  @override
  Future<void> createUser() async {
    try {
      _loadingStateAdd = ELoadingState.loading;
      _loggingService.info('creating user');
      notifyListeners();
      await _userService.createUser(UserCreateDto(
        _dialogMail!,
        _dialogPassword!,
        _dialogFirstname!,
        _dialogLastname!,
        _dialogRole,
        _dialogUnit?.id,
      ));
      _loadingStateAdd = ELoadingState.done;
      _loggingService.info('creating user successful');
    } on OkrApiException catch (error, stackTrace) {
      _loggingService.error('error while creating users', error, stackTrace);
      _loadingStateAdd = ELoadingState.error;
      _snackBarService.errorFromCode(error.errorCode);
    } on TimeoutException catch (error, stackTrace) {
      _loggingService.error('error while creating users', error, stackTrace);
      _loadingStateAdd = ELoadingState.error;
      _snackBarService.errorFromCode(ErrorCodes.requestTimeout);
    } catch (error, stackTrace) {
      _loggingService.error('error while creating users', error, stackTrace);
      _loadingStateAdd = ELoadingState.error;
      _snackBarService.errorFromCode(ErrorCodes.unknownError);
    }
    notifyListeners();
    _dialogMail = null;
    _dialogPassword = null;
    _dialogFirstname = null;
    _dialogLastname = null;
    _dialogRole = ERole.readOnlyUser;
    _dialogUnit = null;
  }
}
