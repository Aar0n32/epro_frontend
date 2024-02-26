import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String title;

  const ProgressBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Title'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                value: 0.2,
              ),
            ),
            SizedBox(width: 8),
            Text('20%')
          ],
        ),
      ],
    );
  }
}
