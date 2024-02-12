import 'dart:ui';

import 'i_app_colors.dart';
import '../generated/base_colors.dart';

class DarkAppColors extends IAppColors {
  @override
  Color get infoForeground => backgroundInformational;

  @override
  Color get infoBackground => primaryMain;

  @override
  Color get successForeground => backgroundSuccess;

  @override
  Color get successBackground => greenGreen700;

  @override
  Color get warningForeground => backgroundWarning;

  @override
  Color get warningBackground => yellowYellow800;

  @override
  Color get errorForeground => backgroundCritical;

  @override
  Color get errorBackground => redRed700;

  @override
  Color get inactive => textMoresubtitle;

  @override
  Color get background => greyGrey900;

  @override
  Color get foreground => backgroundPage;

  @override
  Color get textDefault => backgroundPage;

  @override
  Color get textSubtitle => BaseColors.greyGrey300;

  @override
  Color get textDisabled => BaseColors.greyGrey700;

  @override
  Color get surfaceBackground => BaseColors.greyGrey800;

  @override
  Color get backgroundErgaenzung => BaseColors.customGreyCustomGrey700;

  @override
  Color get profileHeaderBackground => BaseColors.primaryPrimary700.withOpacity(0.3);

  @override
  Color get primaryPrimary => BaseColors.primaryPrimary700;

  @override
  Color get todayBackground => BaseColors.blueBlue200;

  @override
  Color get todayText => BaseColors.textDefault;

  @override
  Color get monthBackground => BaseColors.greyGrey700;

  @override
  Color get indigoBackground => BaseColors.indigoIndigo800;

  @override
  Color get indigoForeground => BaseColors.indigoIndigo50;
}
