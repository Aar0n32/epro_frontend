import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final double value;

  const ProgressBar({super.key, required this.title, required this.value});

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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
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
        ),
      ],
    );
  }
}
