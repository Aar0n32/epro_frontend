import 'dart:ui';

import '../generated/base_colors.dart';

abstract class IAppColors {
  Color get infoForeground;

  Color get infoBackground;

  Color get successForeground;

  Color get successBackground;

  Color get warningForeground;

  Color get warningBackground;

  Color get errorForeground;

  Color get errorBackground;

  Color get inactive;

  Color get background;

  Color get backgroundErgaenzung;

  Color get foreground;

  Color get profileHeaderBackground;

  Color get indigoBackground;

  Color get indigoForeground;

  final Color primaryMain = BaseColors.primaryAppIconColor;

  final Color textHighlight = BaseColors.textHighlight;

  final Color backgroundInformational = BaseColors.backgroundInformational;

  final Color greenGreen100 = BaseColors.greenGreen100;

  final Color greenGreen700 = BaseColors.greenGreen700;

  final Color greenGreen800 = BaseColors.greenGreen800;

  final Color backgroundSuccess = BaseColors.backgroundSuccess;

  final Color yellowYellow800 = BaseColors.yellowYellow800;

  final Color backgroundWarning = BaseColors.backgroundWarning;

  final Color redRed100 = BaseColors.redRed100;

  final Color redRed700 = BaseColors.redRed700;

  final Color backgroundCritical = BaseColors.backgroundCritical;

  final Color greyGrey700 = BaseColors.greyGrey700;

  final Color textMoresubtitle = BaseColors.textMoresubtitle;

  final Color textDefault = BaseColors.textDefault;

  final Color textSubtitle = BaseColors.textSubtitle;

  final Color textDisabled = BaseColors.textDisabled;

  final Color backgroundPage = BaseColors.backgroundPage;

  final Color customGreyCustomGrey100 = BaseColors.customGreyCustomGrey100;

  final Color greyGrey900 = BaseColors.greyGrey900;

  final Color greyGrey300 = BaseColors.greyGrey300;

  final Color greyGrey400 = BaseColors.greyGrey400;

  final Color black = BaseColors.black;

  final Color white = BaseColors.white;

  final Color orangeOrange500 = BaseColors.orangeOrange500;

  final Color primaryPrimary200 = BaseColors.primaryPrimary200;

  final Color primaryPrimary400 = BaseColors.primaryPrimary400;

  final Color primaryPrimary500 = BaseColors.primaryPrimary500;

  final Color customGreyCustomGrey300 = BaseColors.customGreyCustomGrey300;

  final Color elevatedButtonTextColor = BaseColors.greyGrey100;

  Color get surfaceBackground;

  Color get greyGrey500 => BaseColors.greyGrey500;

  final Color secondaryMain = BaseColors.baseSecondaryMain;

  final Color basePrimaryMain = BaseColors.basePrimaryMain;

  Color get primaryPrimary;

  Color get todayBackground;

  Color get todayText;

  final Color textOnColor = BaseColors.textOnColor;

  Color get monthBackground;

  final Color blue500 = BaseColors.blueBlue500;

  final Color amberAmber400 = BaseColors.amberAmber400;
}
