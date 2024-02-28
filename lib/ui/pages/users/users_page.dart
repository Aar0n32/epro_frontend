import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:epro_frontend/ui/pages/settings/components/user_settings_item.dart';
import 'package:epro_frontend/ui/pages/users/components/user_dialog.dart';
import 'package:epro_frontend/ui/pages/users/components/user_item.dart';
import 'package:epro_frontend/ui/shared/error_card.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_image_paths.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<IUnitViewModel>().load();
      if (!context.mounted) return;
      await context.read<IUserViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IUserViewModel userViewModel = context.watch();
    final IUnitViewModel unitViewModel = context.watch();

    Widget? content;

    if(userViewModel.loadingState == ELoadingState.error || unitViewModel.loadingState == ELoadingState.error){
      content = const ErrorCard();
    } else if(userViewModel.loadingState == ELoadingState.done && unitViewModel.loadingState == ELoadingState.done){
      content = ListView.builder(
        itemBuilder: (context, index) =>
            UserItem(userViewModel.user[index]),
        itemCount: userViewModel.user.length,
      );
    } else {
      content = const Center(child: CircularProgressIndicator());
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
            Text(lang.usersTitle),
          ],
        ),
        centerTitle: false,
        actions: const [UserSettingsItem()],
      ),
      floatingActionButton: userViewModel.me?.role == ERole.coOkrAdmin
          ? FloatingActionButton(
              onPressed: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => const UserDialog(),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        ),
      ),
    );
  }
}
