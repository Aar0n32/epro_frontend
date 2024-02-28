import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/ui/pages/settings/components/user_settings_item.dart';
import 'package:epro_frontend/ui/shared/error_card.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/okr_set/i_okr_set_view_model.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/okr_set_item.dart';
import '../../../constants/asset_image_paths.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<IOkrSetViewModel>().load();
      if (!context.mounted) return;
      await context.read<IUserViewModel>().loadMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IOkrSetViewModel okrSetViewModel = context.watch();
    int lastUnitId = -1;
    bool showHeader = false;

    Widget? content;

    switch (okrSetViewModel.loadingState) {
      case ELoadingState.initial:
      case ELoadingState.loading:
        content = const Center(child: CircularProgressIndicator());
      case ELoadingState.done:
        content = ListView.builder(
          itemCount: okrSetViewModel.okrSets.length,
          itemBuilder: (context, index) {
            var okrSet = okrSetViewModel.okrSets[index];
            if (okrSet.unit.id == lastUnitId) {
              showHeader = false;
            } else {
              showHeader = true;
            }
            lastUnitId = okrSet.unit.id;
            return OkrSetItem(
              okrSet: okrSet,
              showHeader: showHeader,
            );
          },
        );
      case ELoadingState.error:
        content = const ErrorCard();
    }

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
            Text(lang.dashboard),
          ],
        ),
        centerTitle: false,
        actions: const [UserSettingsItem()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        ),
      ),
    );
  }
}
