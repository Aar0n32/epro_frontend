import 'package:epro_frontend/ui/shared/progress_bar.dart';
import 'package:flutter/material.dart';

class ProgressBarTile extends StatelessWidget {
  final String title;
  final double value;

  const ProgressBarTile({super.key, required this.title, required this.value});

  String get valueString {
    double rounded = (value * 100.0 * 20.0).round() / 20.0;
    return rounded.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        SizedBox(width: 300, child: ProgressBar(value)),
      ],
    );
  }
}
