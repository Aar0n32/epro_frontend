import 'package:flutter/material.dart';

import 'key_result_history_dialog.dart';
import '../../../shared/progress_bar.dart';
import '../../../../model/key_result.dart';

class KeyResultItem extends StatelessWidget {
  final KeyResult keyResult;

  const KeyResultItem(this.keyResult, {super.key});

  void _changeKeyResultValue(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => KeyResultHistoryDialog(keyResult),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ProgressBar(
        title: keyResult.name,
        value: keyResult.progressPercentage,
      ),
      trailing: IconButton(
        onPressed: () => _changeKeyResultValue(context),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
