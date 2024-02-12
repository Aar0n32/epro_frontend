import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';


import 'configs/injection.dart';
import 'services/logging/i_logging_service.dart';
import 'services/logging/logging_service.dart';

final ILoggingService logger = LoggingService().init('main');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PlatformDispatcher.instance.onError = _handleNotCaughtByFlutterError;
  FlutterError.onError = _handleCaughtByFlutterError;

  try{
    setLocaleMessages('de', DeMessages());
    await configureDependencies();
    logger.info('App Started successfully');
  } catch (error, stackTrace) {
    logger.error('Fatal Error', error, stackTrace);
  }
}

bool _handleNotCaughtByFlutterError(Object uncaughtError, StackTrace uncaughtErrorStackTrace) {
  try {
    logger.error('Error not caught by Flutter', uncaughtError, uncaughtErrorStackTrace);
    // if (uncaughtError is UnauthenticatedUserException) {
    //   final authService = locator.get<IAuthService>();
    //   if (!authService.isCurrentPersonUserAuthenticated) return true;
    //   unawaited(authService.checkAppVerbindung().then((value) {
    //     if (value) return;
    //     unawaited(authService.logout());
    //     locator.get<IRouterService>().goNamed(RouteNames.dashboard);
    //   }));
    // }
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