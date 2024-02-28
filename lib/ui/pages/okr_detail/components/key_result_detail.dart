import 'package:epro_frontend/model/key_result.dart';
import 'package:epro_frontend/ui/pages/okr_detail/components/key_result_history_info_dialog.dart';
import 'package:epro_frontend/ui/shared/progress_bar.dart';
import 'package:epro_frontend/ui/shared/text_input_field.dart';
import 'package:epro_frontend/util/extensions/app_localizations_extension.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:flutter/material.dart';

class KeyResultDetailItem extends StatelessWidget {
  final KeyResult keyResult;

  const KeyResultDetailItem(this.keyResult, {super.key});

  final isEditingModeDisabled = true;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextInputField(
                        label: 'Ziel',
                        value: keyResult.name,
                        noPadding: true,
                        isEditingModeDisabled: isEditingModeDisabled,
                      ),
                      TextInputField(
                        label: 'Beschreibung',
                        value: keyResult.description,
                        noPadding: true,
                        isEditingModeDisabled: isEditingModeDisabled,
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => KeyResultHistoryInfoDialog(
                            keyResult.keyResultHistory ?? []),
                      );
                    },
                    icon: const Icon(Icons.history)),
              ],
            ),
            ProgressBar(keyResult.progressPercentage),
            Row(
              children: [
                Expanded(
                  child: TextInputField(
                    label: 'Aktueller Wert',
                    value: keyResult.currentProgress.toStringAsFixed(2),
                    noPadding: true,
                    isEditingModeDisabled: isEditingModeDisabled,
                  ),
                ),
                Expanded(
                  child: TextInputField(
                    label: 'Ziel Wert',
                    value: keyResult.targetProgress.toStringAsFixed(2),
                    noPadding: true,
                    isEditingModeDisabled: isEditingModeDisabled,
                  ),
                ),
                Expanded(
                  child: TextInputField(
                    label: 'Fortschritts Typ',
                    value: lang.textFromProgressType(keyResult.type),
                    noPadding: true,
                    isEditingModeDisabled: isEditingModeDisabled,
                  ),
                ),
                Expanded(
                  child: TextInputField(
                    label: 'Einzahlend',
                    value: keyResult.okrSetsThatPayIntoThisKeyResult.isEmpty
                        ? '-'
                        : keyResult.okrSetsThatPayIntoThisKeyResult.join(', '),
                    noPadding: true,
                    isEditingModeDisabled: isEditingModeDisabled,
                  ),
                ),
                Expanded(
                  child: TextInputField(
                    label: 'Confidence Level',
                    value: keyResult.confidenceLevel.toString(),
                    noPadding: true,
                    isEditingModeDisabled: isEditingModeDisabled,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
