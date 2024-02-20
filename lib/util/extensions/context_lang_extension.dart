import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configs/injection.dart';
import '../../services/language/i_language_service.dart';

extension ContextLangExtension on BuildContext {
  AppLocalizations lang() {
    try{
      return AppLocalizations.of(this)!;
    }catch (_){
      return locator.get<ILanguageService>().appLocalizations;
    }
  }
}