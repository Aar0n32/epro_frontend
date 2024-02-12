// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i8;

import 'package:device_info_plus/device_info_plus.dart' as _i7;
import 'package:epro_frontend/api/clients/unauthenticated_api_client.dart'
    as _i19;
import 'package:epro_frontend/api/middlewares/auth_middleware.dart' as _i21;
import 'package:epro_frontend/api/pipelines/middleware_pipeline.dart' as _i17;
import 'package:epro_frontend/api/pipelines/unauthenticated_middleware_pipeline.dart'
    as _i20;
import 'package:epro_frontend/configs/app_styles.dart' as _i5;
import 'package:epro_frontend/configs/global_register_module.dart' as _i25;
import 'package:epro_frontend/services/auth/i_auth_service.dart' as _i22;
import 'package:epro_frontend/services/language/i_language_service.dart' as _i9;
import 'package:epro_frontend/services/language/language_service.dart' as _i10;
import 'package:epro_frontend/services/logging/appenders/developer_log_appender.dart'
    as _i3;
import 'package:epro_frontend/services/logging/i_logging_service.dart' as _i11;
import 'package:epro_frontend/services/logging/logging_service.dart' as _i12;
import 'package:epro_frontend/services/router/i_router_service.dart' as _i13;
import 'package:epro_frontend/services/router/router_service.dart' as _i14;
import 'package:epro_frontend/services/snackbar/i_snack_bar_service.dart'
    as _i15;
import 'package:epro_frontend/services/snackbar/snack_bar_service.dart' as _i16;
import 'package:epro_frontend/services/storage/i_local_storage_service.dart'
    as _i23;
import 'package:epro_frontend/services/storage/secure_local_storage_service.dart'
    as _i24;
import 'package:flutter/services.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:new_version_plus/new_version_plus.dart' as _i18;

const String _prod = 'prod';
const String _dev = 'dev';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final globalRegisterModule = _$GlobalRegisterModule();
    gh.singleton<_i3.DeveloperLogAppender>(
        globalRegisterModule.developerLogAppender);
    gh.singleton<_i4.AndroidOptions>(globalRegisterModule.androidOptions());
    gh.singleton<_i5.AppStyles>(_i5.AppStyles());
    gh.singleton<_i6.AssetBundle>(globalRegisterModule.getRootBundle());
    gh.singleton<_i7.DeviceInfoPlugin>(
      globalRegisterModule.deviceInfoPlugin,
      registerFor: {
        _prod,
        _dev,
      },
    );
    await gh.singletonAsync<_i8.Directory>(
      () => globalRegisterModule.appDirectory,
      registerFor: {
        _prod,
        _dev,
      },
      preResolve: true,
    );
    gh.singleton<_i4.FlutterSecureStorage>(
      globalRegisterModule.secureStorage(gh<_i4.AndroidOptions>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.singleton<_i9.ILanguageService>(_i10.LanguageService());
    gh.factory<_i11.ILoggingService>(() => _i12.LoggingService());
    gh.singleton<_i13.IRouterService>(_i14.RouterService());
    gh.singleton<_i15.ISnackBarService>(
        _i16.SnackBarService(gh<_i5.AppStyles>()));
    gh.factory<_i17.MiddlewarePipeline>(
        () => _i17.MiddlewarePipeline(gh<_i11.ILoggingService>()));
    gh.singleton<_i18.NewVersionPlus>(globalRegisterModule.newVersionPlus);
    gh.singleton<_i19.UnauthenticatedApiClient>(_i19.UnauthenticatedApiClient(
        gh<_i20.UnauthenticatedMiddlewarePipeline>()));
    gh.singleton<_i21.AuthMiddleware>(_i21.AuthMiddleware(
      gh<_i22.IAuthService>(),
      gh<_i13.IRouterService>(),
      gh<_i15.ISnackBarService>(),
      gh<_i9.ILanguageService>(),
      gh<_i11.ILoggingService>(),
    ));
    gh.singleton<_i23.ILocalStorageService>(_i24.SecureLocalStorageService(
      gh<_i4.FlutterSecureStorage>(),
      gh<_i11.ILoggingService>(),
    ));
    return this;
  }
}

class _$GlobalRegisterModule extends _i25.GlobalRegisterModule {}
