import 'dart:async';

import 'package:epro_frontend/model/update_key_result.dart';
import 'package:epro_frontend/view_models/okr_set/i_okr_set_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/text_input_field.dart';
import '../../../../constants/enums/e_loading_state.dart';
import '../../../../model/key_result.dart';
import '../../../../util/extensions/app_localizations_extension.dart';
import '../../../../util/extensions/context_lang_extension.dart';
import '../../../../view_models/okr_set/i_key_result_history_view_model.dart';

class KeyResultHistoryDialog extends StatefulWidget {
  final KeyResult keyResult;

  const KeyResultHistoryDialog(this.keyResult, {super.key});

  @override
  State<KeyResultHistoryDialog> createState() => _KeyResultHistoryDialogState();
}

class _KeyResultHistoryDialogState extends State<KeyResultHistoryDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _newValue;
  String? _comment;

  Future<void> _addKeyResultHistory() async {
    final IKeyResultHistoryViewModel keyResultHistoryViewModel = context.read();
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await keyResultHistoryViewModel.addKeyResultHistory(
        UpdateKeyResult(
          widget.keyResult.id,
          double.parse(_newValue!),
          _comment!,
          widget.keyResult.type,
        ),
        widget.keyResult.okrSetId,
      );
      if (keyResultHistoryViewModel.loadingState != ELoadingState.error) {
        if (!context.mounted) return;
        unawaited(context.read<IOkrSetViewModel>().load());
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IKeyResultHistoryViewModel keyResultHistoryViewModel =
        context.watch();

    return Stack(
      children: [
        AlertDialog(
          title: Text(lang.historyTitle),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextInputField(
                        label: lang.historyAktuellerWert,
                        isEditingModeDisabled: true,
                        value: widget.keyResult.currentProgress.toString(),
                      ),
                    ),
                    Expanded(
                      child: TextInputField(
                        label: lang.historyZielWert,
                        isEditingModeDisabled: true,
                        value: widget.keyResult.targetProgress.toString(),
                      ),
                    ),
                    Expanded(
                      child: TextInputField(
                        label: lang.historyType,
                        isEditingModeDisabled: true,
                        value: lang.textFromProgressType(widget.keyResult.type),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: TextInputField(
                        label: lang.historyNeuerWert,
                        onChanged: (value) => _newValue = value,
                        validator: (value) => keyResultHistoryViewModel
                            .newValueValidator(value, widget.keyResult),
                      ),
                    ),
                  ],
                ),
                TextInputField(
                  label: lang.historyKommentar,
                  onChanged: (value) => _comment = value,
                  validator: keyResultHistoryViewModel.commentValidator,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(lang.abbrechen)),
            TextButton(
              onPressed: _addKeyResultHistory,
              child: Text(lang.speichern),
            ),
          ],
        ),
        if (keyResultHistoryViewModel.loadingState == ELoadingState.loading)
          const Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
        if (keyResultHistoryViewModel.loadingState == ELoadingState.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
