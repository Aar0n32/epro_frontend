import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/settings/i_settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_image_paths.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final ISettingsViewModel settingsViewModel = context.watch();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                AssetImagePaths.okrLogoSmall,
                height: 56,
              ),
            ),
            Text(lang.einstellungen),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(lang.einstellungenAbmelden),
                trailing: const Icon(Icons.logout),
                onTap: settingsViewModel.logout,
              ),
              const Divider(),
              ListTile(
                title: Text(lang.einstellungenUnit),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: Text(lang.einstellungenNutzer),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
