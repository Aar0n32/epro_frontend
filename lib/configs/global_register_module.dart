import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/logging/appenders/developer_log_appender.dart';

const defaultEnvironments = [Environment.prod, Environment.dev];

@module
abstract class GlobalRegisterModule {
  @preResolve
  @Singleton(env: defaultEnvironments)
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @Singleton(order: -1)
  DeveloperLogAppender get developerLogAppender {
    return DeveloperLogAppender()..attachToLogger(Logger.root);
  }

  @singleton
  AssetBundle getRootBundle() => rootBundle;

  @Singleton(env: defaultEnvironments)
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}