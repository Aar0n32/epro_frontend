import 'dart:ui';

import 'i_app_colors.dart';
import '../generated/base_colors.dart';

class LightAppColors extends IAppColors {
  @override
  Color get infoForeground => primaryMain;

  @override
  Color get infoBackground => backgroundInformational;

  @override
  Color get successForeground => greenGreen700;

  @override
  Color get successBackground => backgroundSuccess;

  @override
  Color get warningForeground => yellowYellow800;

  @override
  Color get warningBackground => backgroundWarning;

  @override
  Color get errorForeground => redRed700;

  @override
  Color get errorBackground => backgroundCritical;

  @override
  Color get inactive => greyGrey700;

  @override
  Color get background => backgroundPage;

  @override
  Color get foreground => greyGrey900;

  @override
  Color get surfaceBackground => BaseColors.greyGrey100;

  @override
  Color get backgroundErgaenzung => BaseColors.customGreyCustomGrey100;

  @override
  Color get profileHeaderBackground => BaseColors.primaryPrimary50;

  @override
  Color get primaryPrimary => BaseColors.primaryPrimary100;

  @override
  Color get todayBackground => BaseColors.blueBlue700;

  @override
  Color get todayText => BaseColors.textOnColor;

  @override
  Color get monthBackground => BaseColors.bluegreyBluegrey100;

  @override
  Color get indigoBackground => BaseColors.indigoIndigo50;

  @override
  Color get indigoForeground => BaseColors.indigoIndigo800;
}
