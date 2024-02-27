import 'package:epro_frontend/constants/enums/e_error_codes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/enums/e_progress_type.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String textFromProgressType(EProgressType progressType) {
    switch (progressType) {
      case EProgressType.binary:
        return historyTypeBinary;
      case EProgressType.numeric:
        return historyTypeNumerisch;
      case EProgressType.percentage:
        return historyTypeProzent;
    }
  }

  String textFromErrorCode(ErrorCodes errorCode) {
    switch (errorCode) {
      case ErrorCodes.unauthorizedUser:
        return errorUnauthorized;
      case ErrorCodes.forbiddenAction:
        return errorForbiddenAction;
      case ErrorCodes.serverNotAvailable:
      case ErrorCodes.noInternetConnection:
      case ErrorCodes.requestTimeout:
        return errorServerNachricht;
      case ErrorCodes.internalServerError:
      case ErrorCodes.badRequest:
      case ErrorCodes.unknownError:
        return errorStandardNachricht;
    }
  }
}
