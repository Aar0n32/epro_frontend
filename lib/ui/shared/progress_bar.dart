import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;

  const ProgressBar(this.value, {super.key});

  String get valueString {
    double rounded = (value * 100.0 * 20.0).round() / 20.0;
    return rounded.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: value,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 65,
          child: Text(
            '$valueString%',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
