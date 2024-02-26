import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../auth/i_auth_service.dart';
import '../logging/i_logging_service.dart';
import '../storage/i_local_storage_service.dart';
import '../../api/apis/auth_api.dart';
import '../../model/login_dto.dart';
import '../../model/tokens_dto.dart';

@preResolve
@Singleton(as: IAuthService)
class AuthService with ChangeNotifier implements IAuthService {
  final ILocalStorageService _localStorageService;
  final AuthApi _authApi;
  final ILoggingService _loggingService;

  AuthService(this._localStorageService, this._authApi, this._loggingService) {
    _loggingService.init(runtimeType.toString());
  }

  @factoryMethod
  static Future<IAuthService> create(
    ILocalStorageService localStorageService,
    AuthApi authApi,
    ILoggingService loggingService,
  ) async {
    IAuthService authService =
        AuthService(localStorageService, authApi, loggingService);
    await authService.init();
    return authService;
  }

  @override
  Future<void> init() async {
    _loggingService.info('initializing...');
    _tokens = await _localStorageService.loadTokens();
    if (_tokens == null) {
      _loggingService.info('no tokens found');
      return;
    }
    _loggingService.info('tokens loaded');
  }

  TokensDto? _tokens;

  @override
  List<String> get authentication =>
      ['Authorization' 'Bearer ${_tokens?.accessToken}'];

  @override
  bool get isAuthenticated => _tokens?.accessToken != null;

  @override
  String? get token => _tokens?.accessToken;

  @override
  Future<void> login(LoginDto loginDto, bool remember) async {
    _loggingService.info('login start...');
    _tokens = await _authApi.login(loginDto);
    if (_tokens == null) {
      _loggingService.info('requested tokens are null');
      return;
    }
    if (remember) {
      _localStorageService.saveTokens(_tokens!);
      _loggingService.info('tokens saved');
    } else {
      _localStorageService.clearTokens();
      _loggingService.info('tokens cleared');
    }
    _loggingService.info('login sucsessful');
  }

  @override
  Future<void> logout() async {
    _loggingService.info('logout start...');
    try{
      await _authApi.logout(token!);
      _loggingService.info('logout successful');
    }finally{
      _tokens = null;
      await _localStorageService.clearTokens();
    }
  }
}
