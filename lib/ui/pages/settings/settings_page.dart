import 'package:epro_frontend/constants/route_names.dart';
import 'package:epro_frontend/services/router/i_router_service.dart';
import 'package:epro_frontend/ui/pages/settings/components/user_settings_item.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_image_paths.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<IUserViewModel>().loadMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IRouterService routerService = context.watch();

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
        actions: const [UserSettingsItem(onSettingsPage: true)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(lang.einstellungenUnit),
                onTap: () => routerService.goNamed(RouteNames.units),
              ),
              const Divider(),
              ListTile(
                title: Text(lang.einstellungenNutzer),
                onTap: () => routerService.goNamed(RouteNames.users),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
