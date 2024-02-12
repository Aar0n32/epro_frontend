import 'dart:ui';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../constants/enums/e_locale_names.dart';

abstract class ILanguageService {
  ELocaleNames get defaultAppLocaleName;

  AppLocalizations get appLocalizations;

  void updateLocale(Locale? locale);
}
