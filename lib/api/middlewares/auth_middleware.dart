import 'package:http/http.dart';

import 'package:injectable/injectable.dart';

import 'i_middleware.dart';
import '../request_context.dart';
import '../../services/auth/i_auth_service.dart';
import '../../services/language/i_language_service.dart';
import '../../services/logging/i_logging_service.dart';
import '../../services/router/i_router_service.dart';
import '../../services/snackbar/i_snack_bar_service.dart';

@singleton
class AuthMiddleware implements IMiddleware {
  final IAuthService _authService;
  final IRouterService _routerService;
  final ISnackBarService _snackBarService;
  final ILanguageService _languageService;
  final ILoggingService? _loggingService;

  AuthMiddleware(this._authService, this._routerService, this._snackBarService,
      this._languageService, this._loggingService) {
    _loggingService?.init(runtimeType.toString());
  }

  @override
  Future<Response> execute(
      {required Future<Response> Function(RequestContext) next,
      required RequestContext requestContext,}) async {
    try{
      _loggingService?.debug('setting header "Authorization = Bearer ${_authService.token}"');
      requestContext.headerParams['Authorization'] = 'Bearer ${_authService.token}';
      return await next(requestContext);
    } on UnauthenticatedUserException {
      await _handleUnauthanticatedUserException();
      rethrow;
    }
  }

  Future<void> _handleUnauthanticatedUserException() async {

  }
}

class UnauthenticatedUserException implements Exception{} // TODO: add own implementation