import 'dart:ui';

import 'package:epro_frontend/view_models/settings/i_settings_view_model.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'material_page_route_with_overlay.dart';
import '../configs/app_styles.dart';
import '../configs/injection.dart';
import '../services/auth/i_auth_service.dart';
import '../services/language/i_language_service.dart';
import '../services/router/i_router_service.dart';
import '../services/snackbar/i_snack_bar_service.dart';
import '../view_models/login/i_login_view_model.dart';
import '../view_models/okr_set/i_key_result_history_view_model.dart';
import '../view_models/okr_set/i_okr_set_view_model.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final AppStyles _appStyle = locator.get();
  final ILanguageService _languageService = locator.get();
  final IRouterService _routerService = locator.get();
  final ISnackBarService _snackBarService = locator.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppStyles styles = locator.get();
    styles.isDarkMode = () => false;
    // styles.isDarkMode =
    //     () => PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    styles.handleOnBrightnessChanged();
    final defaultBrightnessCallback =
        PlatformDispatcher.instance.onPlatformBrightnessChanged;
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () async {
      if (defaultBrightnessCallback != null) defaultBrightnessCallback();
      styles.handleOnBrightnessChanged();
    };
  }

  @override
  Widget build(BuildContext context) {
    _appStyle.initThemeData(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _snackBarService),
        ChangeNotifierProvider(create: (_) => _routerService),
        ChangeNotifierProvider(create: (_) => locator.get<IAuthService>()),
        ChangeNotifierProvider(create: (_) => locator.get<ILoginViewModel>()),
        ChangeNotifierProvider(create: (_) => locator.get<IUserViewModel>()),
        ChangeNotifierProvider(create: (_) => locator.get<IOkrSetViewModel>()),
        ChangeNotifierProvider(create: (_) => locator.get<IKeyResultHistoryViewModel>()),
        ChangeNotifierProvider(create: (_) => locator.get<ISettingsViewModel>()),
        ChangeNotifierProvider(create: (_) => locator.get<IUnitViewModel>()),
        ChangeNotifierProvider(create: (_) => _appStyle),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: _snackBarService.messangerKey,
        title: 'OKR',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // theme: ThemeData.from(colorScheme: ColorScheme.fromSwatch()),
        theme: _appStyle.lightThemeData,
        // darkTheme: _appStyle.darkThemeData,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) =>
            MaterialPageRouteWithOverlay(child: child!),
        routerConfig: _routerService.routerConfig,
        localeListResolutionCallback: (locales, localeList) {
          _languageService.updateLocale(locales?.first);
          return locales?.first;
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
