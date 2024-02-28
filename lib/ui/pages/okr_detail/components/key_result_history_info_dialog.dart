import 'package:epro_frontend/model/key_result_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KeyResultHistoryInfoDialog extends StatelessWidget {
  final List<KeyResultHistory> keyResultHistory;

  const KeyResultHistoryInfoDialog(this.keyResultHistory, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const  Text('Key Result Änderungsverlauf'),
      content: SizedBox(
        width: 800,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FixedColumnWidth(100),
            2: FixedColumnWidth(150),
          },
          children: [
            const TableRow(
              children: [
                TableCell(child: Center(child: Text('Wert'))),
                TableCell(child: Center(child: Text('Kommentar'))),
                TableCell(child: Center(child: Text('Datum'))),
              ],
            ),
            ...keyResultHistory
                .map((e) => TableRow(
                      children: [
                        TableCell(
                            child: Center(
                                child: Text(e.progress.toStringAsFixed(2)))),
                        TableCell(child: Center(child: Text(e.comment))),
                        TableCell(
                            child: Center(
                                child: Text(DateFormat('dd.MM.yyyy hh:MM')
                                    .format(e.date)))),
                      ],
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

// class KeyResultHistoryItem extends StatelessWidget {
//   const KeyResultHistoryItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [],
//     );
//   }
// }
