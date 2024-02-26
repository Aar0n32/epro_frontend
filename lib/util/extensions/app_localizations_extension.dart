import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/enums/e_progress_type.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String textFromProgressType(EProgressType progressType){
    switch(progressType){
      case EProgressType.binary:
        return historyTypeBinary;
      case EProgressType.numeric:
        return historyTypeNumerisch;
      case EProgressType.percentage:
        return historyTypeProzent;
    }
  }
}