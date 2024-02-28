// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i6;
import 'package:epro_frontend/api/api_register_module.dart' as _i52;
import 'package:epro_frontend/api/apis/auth_api.dart' as _i20;
import 'package:epro_frontend/api/apis/okr_set_api.dart' as _i32;
import 'package:epro_frontend/api/apis/unit_api.dart' as _i33;
import 'package:epro_frontend/api/apis/user_api.dart' as _i34;
import 'package:epro_frontend/api/clients/authenticated_api_client.dart'
    as _i31;
import 'package:epro_frontend/api/clients/unauthenticated_api_client.dart'
    as _i19;
import 'package:epro_frontend/api/middlewares/api_exception_middleware.dart'
    as _i15;
import 'package:epro_frontend/api/middlewares/auth_middleware.dart' as _i27;
import 'package:epro_frontend/api/pipelines/authenticated_middleware_pipeline.dart'
    as _i28;
import 'package:epro_frontend/api/pipelines/middleware_pipeline.dart' as _i13;
import 'package:epro_frontend/api/pipelines/unauthenticated_middleware_pipeline.dart'
    as _i18;
import 'package:epro_frontend/configs/app_styles.dart' as _i4;
import 'package:epro_frontend/configs/global_register_module.dart' as _i51;
import 'package:epro_frontend/services/auth/auth_service.dart' as _i22;
import 'package:epro_frontend/services/auth/i_auth_service.dart' as _i21;
import 'package:epro_frontend/services/language/i_language_service.dart' as _i7;
import 'package:epro_frontend/services/language/language_service.dart' as _i8;
import 'package:epro_frontend/services/logging/appenders/developer_log_appender.dart'
    as _i3;
import 'package:epro_frontend/services/logging/i_logging_service.dart' as _i9;
import 'package:epro_frontend/services/logging/logging_service.dart' as _i10;
import 'package:epro_frontend/services/okr_set/i_okr_set_service.dart' as _i35;
import 'package:epro_frontend/services/okr_set/okr_set_service.dart' as _i36;
import 'package:epro_frontend/services/router/i_router_service.dart' as _i23;
import 'package:epro_frontend/services/router/router_service.dart' as _i24;
import 'package:epro_frontend/services/snackbar/i_snack_bar_service.dart'
    as _i11;
import 'package:epro_frontend/services/snackbar/snack_bar_service.dart' as _i12;
import 'package:epro_frontend/services/storage/i_local_storage_service.dart'
    as _i16;
import 'package:epro_frontend/services/storage/local_storage_service.dart'
    as _i17;
import 'package:epro_frontend/services/unit/i_unit_service.dart' as _i39;
import 'package:epro_frontend/services/unit/unit_service.dart' as _i40;
import 'package:epro_frontend/services/user/i_user_service.dart' as _i43;
import 'package:epro_frontend/services/user/user_service.dart' as _i44;
import 'package:epro_frontend/view_models/login/i_login_view_model.dart'
    as _i29;
import 'package:epro_frontend/view_models/login/login_view_model.dart' as _i30;
import 'package:epro_frontend/view_models/okr_set/i_key_result_history_view_model.dart'
    as _i47;
import 'package:epro_frontend/view_models/okr_set/i_okr_set_detail_view_model.dart'
    as _i49;
import 'package:epro_frontend/view_models/okr_set/i_okr_set_view_model.dart'
    as _i37;
import 'package:epro_frontend/view_models/okr_set/key_result_history_view_model.dart'
    as _i48;
import 'package:epro_frontend/view_models/okr_set/okr_set_detail_view_model.dart'
    as _i50;
import 'package:epro_frontend/view_models/okr_set/okr_set_view_model.dart'
    as _i38;
import 'package:epro_frontend/view_models/settings/i_settings_view_model.dart'
    as _i25;
import 'package:epro_frontend/view_models/settings/settings_view_model.dart'
    as _i26;
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart' as _i41;
import 'package:epro_frontend/view_models/unit/unit_view_model.dart' as _i42;
import 'package:epro_frontend/view_models/user/i_user_view_model.dart' as _i45;
import 'package:epro_frontend/view_models/user/user_view_model.dart' as _i46;
import 'package:flutter/services.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

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
    final apiRegisterModule = _$ApiRegisterModule();
    gh.singleton<_i3.DeveloperLogAppender>(
        globalRegisterModule.developerLogAppender);
    gh.singleton<_i4.AppStyles>(_i4.AppStyles());
    gh.singleton<_i5.AssetBundle>(globalRegisterModule.getRootBundle());
    gh.singleton<_i6.DeviceInfoPlugin>(
      globalRegisterModule.deviceInfoPlugin,
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.singleton<_i7.ILanguageService>(_i8.LanguageService());
    gh.factory<_i9.ILoggingService>(() => _i10.LoggingService());
    gh.singleton<_i11.ISnackBarService>(_i12.SnackBarService(
      gh<_i4.AppStyles>(),
      gh<_i7.ILanguageService>(),
    ));
    gh.factory<_i13.MiddlewarePipeline>(
        () => _i13.MiddlewarePipeline(gh<_i9.ILoggingService>()));
    await gh.singletonAsync<_i14.SharedPreferences>(
      () => globalRegisterModule.prefs,
      registerFor: {
        _prod,
        _dev,
      },
      preResolve: true,
    );
    gh.singleton<_i15.ApiExceptionMiddleware>(
        _i15.ApiExceptionMiddleware(gh<_i9.ILoggingService>()));
    gh.singleton<_i16.ILocalStorageService>(_i17.LocalStorageService(
      gh<_i14.SharedPreferences>(),
      gh<_i9.ILoggingService>(),
    ));
    gh.factory<_i18.UnauthenticatedMiddlewarePipeline>(
        () => _i18.UnauthenticatedMiddlewarePipeline.create(
              gh<_i9.ILoggingService>(),
              gh<_i15.ApiExceptionMiddleware>(),
            ));
    gh.singleton<_i19.UnauthenticatedApiClient>(_i19.UnauthenticatedApiClient(
        gh<_i18.UnauthenticatedMiddlewarePipeline>()));
    gh.singleton<_i20.AuthApi>(
        apiRegisterModule.authApi(gh<_i19.UnauthenticatedApiClient>()));
    await gh.singletonAsync<_i21.IAuthService>(
      () => _i22.AuthService.create(
        gh<_i16.ILocalStorageService>(),
        gh<_i20.AuthApi>(),
        gh<_i9.ILoggingService>(),
      ),
      preResolve: true,
    );
    gh.singleton<_i23.IRouterService>(
        _i24.RouterService.create(gh<_i21.IAuthService>()));
    gh.singleton<_i25.ISettingsViewModel>(_i26.SettingsViewModel(
      gh<_i9.ILoggingService>(),
      gh<_i23.IRouterService>(),
      gh<_i21.IAuthService>(),
    ));
    gh.singleton<_i27.AuthMiddleware>(_i27.AuthMiddleware(
      gh<_i21.IAuthService>(),
      gh<_i23.IRouterService>(),
      gh<_i11.ISnackBarService>(),
      gh<_i7.ILanguageService>(),
      gh<_i9.ILoggingService>(),
    ));
    gh.factory<_i28.AuthenticatedMiddlewarePipeline>(
        () => _i28.AuthenticatedMiddlewarePipeline.create(
              gh<_i9.ILoggingService>(),
              gh<_i15.ApiExceptionMiddleware>(),
              gh<_i27.AuthMiddleware>(),
            ));
    gh.singleton<_i29.ILoginViewModel>(_i30.LoginViewModel(
      gh<_i21.IAuthService>(),
      gh<_i23.IRouterService>(),
      gh<_i7.ILanguageService>(),
      gh<_i11.ISnackBarService>(),
      gh<_i9.ILoggingService>(),
    ));
    gh.singleton<_i31.AuthenticatedApiClient>(_i31.AuthenticatedApiClient(
        gh<_i28.AuthenticatedMiddlewarePipeline>()));
    gh.singleton<_i32.OkrSetAPi>(
        apiRegisterModule.okrSetAPi(gh<_i31.AuthenticatedApiClient>()));
    gh.singleton<_i33.UnitApi>(
        apiRegisterModule.unitApi(gh<_i31.AuthenticatedApiClient>()));
    gh.singleton<_i34.UserApi>(
        apiRegisterModule.userApi(gh<_i31.AuthenticatedApiClient>()));
    gh.singleton<_i35.IOkrSetService>(_i36.OkrSetService(gh<_i32.OkrSetAPi>()));
    gh.singleton<_i37.IOkrSetViewModel>(_i38.OkrSetViewModel(
      gh<_i9.ILoggingService>(),
      gh<_i35.IOkrSetService>(),
    ));
    gh.singleton<_i39.IUnitService>(_i40.UnitService(gh<_i33.UnitApi>()));
    gh.singleton<_i41.IUnitViewModel>(_i42.UnitViewModel(
      gh<_i9.ILoggingService>(),
      gh<_i11.ISnackBarService>(),
      gh<_i39.IUnitService>(),
    ));
    gh.singleton<_i43.IUserService>(_i44.UserService(gh<_i34.UserApi>()));
    gh.singleton<_i45.IUserViewModel>(_i46.UserViewModel(
      gh<_i9.ILoggingService>(),
      gh<_i11.ISnackBarService>(),
      gh<_i7.ILanguageService>(),
      gh<_i43.IUserService>(),
    ));
    gh.singleton<_i47.IKeyResultHistoryViewModel>(
        _i48.KeyResultHistoryViewModel(
      gh<_i9.ILoggingService>(),
      gh<_i11.ISnackBarService>(),
      gh<_i7.ILanguageService>(),
      gh<_i35.IOkrSetService>(),
    ));
    gh.singleton<_i49.IOkrSetDetailViewModel>(_i50.OkrSetDetailViewModel(
      gh<_i9.ILoggingService>(),
      gh<_i35.IOkrSetService>(),
    ));
    return this;
  }
}

class _$GlobalRegisterModule extends _i51.GlobalRegisterModule {}

class _$ApiRegisterModule extends _i52.ApiRegisterModule {}
