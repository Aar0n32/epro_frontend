import 'package:epro_frontend/constants/enums/e_error_codes.dart';
import 'package:epro_frontend/services/language/i_language_service.dart';
import 'package:epro_frontend/util/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'i_snack_bar_service.dart';
import '../../configs/app_styles.dart';
import '../../constants/enums/e_status_variant.dart';

@Singleton(as: ISnackBarService)
class SnackBarService extends ISnackBarService with ChangeNotifier {
  final AppStyles _appStyle;
  final ILanguageService _languageService;
  @override
  final GlobalKey<ScaffoldMessengerState> messangerKey =
      GlobalKey<ScaffoldMessengerState>();

  SnackBarService(this._appStyle, this._languageService);

  void showSnackBar(
      {required EStatusVariant statusVariant, required String text}) {
    final Color statusColor;
    final Icon statusIcon;
    final Color textColor;

    switch (statusVariant) {
      case EStatusVariant.success:
        statusColor = _appStyle.colors.successBackground;
        statusIcon = Icon(Icons.check_circle_outline,
            color: _appStyle.colors.successForeground);
        textColor = _appStyle.colors.successForeground;
        break;
      case EStatusVariant.info:
        statusColor = _appStyle.colors.infoBackground;
        statusIcon =
            Icon(Icons.info_outlined, color: _appStyle.colors.infoForeground);
        textColor = _appStyle.colors.infoForeground;
        break;
      case EStatusVariant.warning:
        statusColor = _appStyle.colors.warningBackground;
        statusIcon = Icon(Icons.warning_outlined,
            color: _appStyle.colors.warningForeground);
        textColor = _appStyle.colors.warningForeground;
        break;
      case EStatusVariant.error:
      default:
        statusColor = _appStyle.colors.errorBackground;
        statusIcon =
            Icon(Icons.error_outline, color: _appStyle.colors.errorForeground);
        textColor = _appStyle.colors.errorForeground;
        break;
    }
    _showSnackBar(
        statusColor: statusColor,
        statusIcon: statusIcon,
        textColor: textColor,
        text: text);
  }

  @override
  void error(String text) {
    showSnackBar(statusVariant: EStatusVariant.error, text: text);
  }

  @override
  void info(String text) {
    showSnackBar(statusVariant: EStatusVariant.info, text: text);
  }

  @override
  void success(String text) {
    showSnackBar(statusVariant: EStatusVariant.success, text: text);
  }

  @override
  void warning(String text) {
    showSnackBar(statusVariant: EStatusVariant.warning, text: text);
  }

  @override
  void errorFromCode(ErrorCodes errorCode) {
    showSnackBar(
      statusVariant: EStatusVariant.error,
      text: _languageService.appLocalizations.textFromErrorCode(errorCode),
    );
  }

  void _showSnackBar(
      {required Color statusColor,
      required Icon statusIcon,
      required Color textColor,
      required String text}) {
    messangerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: statusColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          statusIcon,
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: _appStyle.currentTheme.textTheme.titleLarge
                  ?.copyWith(color: textColor),
              maxLines: 5,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
