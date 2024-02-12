
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../constants/styles/colors/dark_app_colors.dart';
import '../constants/styles/colors/i_app_colors.dart';
import '../constants/styles/colors/light_app_colors.dart';
import '../constants/styles/generated/base_typography.dart';

@singleton
class AppStyles with ChangeNotifier {
  late IAppColors colors;

  late final VoidCallback? defaultPlatformBrightnessHandler;

  late ThemeData _lightThemeData;

  late ThemeData _darkThemeData;

  AppStyles() {
    colors = LightAppColors();
  }

  late bool Function() isDarkMode;

  ThemeData get currentTheme => isDarkMode() ? _darkThemeData : _lightThemeData;

  ThemeData get lightThemeData => _lightThemeData;

  ThemeData get darkThemeData => _darkThemeData;

  void initThemeData(BuildContext context) {
    _lightThemeData = _getThemeData(
      context,
      appColors: LightAppColors(),
      themeData: ThemeData.light(useMaterial3: false),
    );
    _darkThemeData = _getThemeData(
      context,
      appColors: DarkAppColors(),
      themeData: ThemeData.dark(useMaterial3: false),
    );
  }

  ThemeData _getThemeData(BuildContext context, {required ThemeData themeData, required IAppColors appColors}) {
    final baseTypography = BaseTypography(textTheme: themeData.textTheme);
    final theme = Theme.of(context);
    return themeData.copyWith(
      primaryColor: appColors.primaryMain,
      appBarTheme: theme.appBarTheme.copyWith(
          actionsIconTheme: theme.appBarTheme.actionsIconTheme?.copyWith(color: appColors.foreground),
          backgroundColor: appColors.background,
          foregroundColor: appColors.foreground,
          iconTheme: IconThemeData(color: appColors.foreground)),
      iconTheme: theme.iconTheme.copyWith(color: appColors.foreground),
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: appColors.foreground),
      textTheme: TextTheme(
        displayLarge: baseTypography.headline100?.copyWith(color: appColors.textDefault),
        displayMedium: baseTypography.headline200?.copyWith(color: appColors.textDefault),
        displaySmall: baseTypography.headline300?.copyWith(color: appColors.textDefault),
        headlineMedium: baseTypography.headline400?.copyWith(color: appColors.textDefault),
        headlineSmall: baseTypography.headline500?.copyWith(color: appColors.textDefault),
        titleLarge: baseTypography.headline600?.copyWith(color: appColors.textDefault),
        titleMedium: baseTypography.subtitle100?.copyWith(color: appColors.textDefault),
        titleSmall: baseTypography.subtitle200?.copyWith(color: appColors.textDefault),
        labelLarge: baseTypography.button,
        labelSmall: baseTypography.overline,
        bodyLarge: baseTypography.body100,
        bodyMedium: baseTypography.body200,
        bodySmall: baseTypography.caption,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(appColors.primaryMain),
        ),
      ),
      buttonTheme: theme.buttonTheme.copyWith(
        buttonColor: appColors.primaryMain,
        colorScheme: theme.buttonTheme.colorScheme?.copyWith(
          background: appColors.primaryMain,
        ),
      ),
      floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(backgroundColor: appColors.foreground),
      listTileTheme: theme.listTileTheme.copyWith(iconColor: appColors.foreground),
      tabBarTheme: theme.tabBarTheme.copyWith(labelColor: appColors.foreground),
    );
  }

  void handleOnBrightnessChanged() {
    colors = isDarkMode() ? DarkAppColors() : LightAppColors();
    notifyListeners();
  }
}
