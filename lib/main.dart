import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';

import 'configs/injection.dart';
import 'constants/route_names.dart';
import 'exceptions/okr_api_exception.dart';
import 'services/logging/i_logging_service.dart';
import 'services/logging/logging_service.dart';
import 'services/auth/i_auth_service.dart';
import 'services/router/i_router_service.dart';
import 'ui/main_app.dart';

final ILoggingService logger = LoggingService().init('main');


Future<void> main() async {
  Intl.defaultLocale = 'de_DE';
  ValidationBuilder.setLocale('de');
  WidgetsFlutterBinding.ensureInitialized();
  PlatformDispatcher.instance.onError = _handleNotCaughtByFlutterError;
  FlutterError.onError = _handleCaughtByFlutterError;

  try {
    setLocaleMessages('de', DeMessages());
    configureDependencies();
    runApp(const MainApp());
    logger.info('App Started successfully');
  } catch (error, stackTrace) {
    logger.error('Fatal Error', error, stackTrace);
    print(error);
    rethrow;
  }
}

bool _handleNotCaughtByFlutterError(
    Object uncaughtError, StackTrace uncaughtErrorStackTrace) {
  try {
    logger.error(
        'Error not caught by Flutter', uncaughtError, uncaughtErrorStackTrace);
    if (uncaughtError is UnauthenticatedUserException) {
      final authService = locator.get<IAuthService>();
      if (!authService.isAuthenticated) return true;
      authService.logout();
      locator.get<IRouterService>().goNamed(RouteNames.dashboard);
    }
    return true;
  } catch (e, s) {
    logger.error('Fatal error', e, s);
    return false;
  }
}

void _handleCaughtByFlutterError(FlutterErrorDetails details) {
  FlutterError.presentError(details);
  logger.error('Build Error: ', details, details.stack);
}
