import 'package:epro_frontend/configs/app_styles.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final appStyle = context.watch<AppStyles>();

    return Card(
      color: appStyle.colors.errorBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              lang.error,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: appStyle.colors.errorForeground),
            ),
            Text(
              lang.errorStandardNachricht,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: appStyle.colors.errorForeground),
            ),
          ],
        ),
      ),
    );
  }
}
