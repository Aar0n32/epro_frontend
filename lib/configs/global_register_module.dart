import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../services/logging/appenders/developer_log_appender.dart';

const defaultEnvironments = [Environment.prod, Environment.dev];

@module
abstract class GlobalRegisterModule {
  @preResolve
  @Singleton(env: defaultEnvironments)
  Future<Directory> get appDirectory => getApplicationDocumentsDirectory();

  @singleton
  NewVersionPlus get newVersionPlus => NewVersionPlus(
    androidPlayStoreCountry: Platform.localeName,
  );

  @singleton
  AndroidOptions androidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  @Singleton(env: defaultEnvironments)
  FlutterSecureStorage secureStorage(AndroidOptions androidOptions) => FlutterSecureStorage(aOptions: androidOptions);

  @Singleton(order: -1)
  DeveloperLogAppender get developerLogAppender {
    return DeveloperLogAppender()..attachToLogger(Logger.root);
  }

  @singleton
  AssetBundle getRootBundle() => rootBundle;

  @Singleton(env: defaultEnvironments)
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}