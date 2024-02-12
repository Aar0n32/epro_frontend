import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_de.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:injectable/injectable.dart';


import 'i_language_service.dart';
import '../../../constants/enums/e_locale_names.dart';

@Singleton(as: ILanguageService)
class LanguageService extends ILanguageService {
  ELocaleNames _defaultAppLocaleName = ELocaleNames.de;

  @override
  ELocaleNames get defaultAppLocaleName => _defaultAppLocaleName;
  AppLocalizations _appLocalizations = AppLocalizationsDe();

  @override
  void updateLocale(Locale? locale) {
    _defaultAppLocaleName = ELocaleNames.values
        .firstWhere((element) => element.name == locale?.languageCode, orElse: () => ELocaleNames.de);
    switch (_defaultAppLocaleName) {
      case ELocaleNames.de:
        if (_appLocalizations.runtimeType is! AppLocalizationsDe) _appLocalizations = AppLocalizationsDe();
        break;
      case ELocaleNames.en:
        if (_appLocalizations.runtimeType is! AppLocalizationsEn) _appLocalizations = AppLocalizationsEn();
        break;
      default:
        if (_appLocalizations.runtimeType is! AppLocalizationsDe) _appLocalizations = AppLocalizationsDe();
        break;
    }
  }

  @override
  AppLocalizations get appLocalizations => _appLocalizations;
}
