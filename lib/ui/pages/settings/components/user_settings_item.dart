import 'package:epro_frontend/constants/route_names.dart';
import 'package:epro_frontend/model/user.dart';
import 'package:epro_frontend/services/router/i_router_service.dart';
import 'package:epro_frontend/util/extensions/app_localizations_extension.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/settings/i_settings_view_model.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSettingsItem extends StatelessWidget {
  final bool onSettingsPage;

  const UserSettingsItem({super.key, this.onSettingsPage = false});

  RelativeRect buttonMenuPosition(BuildContext context) {
    final RenderBox bar = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    const Offset offset = Offset.zero;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.bottomRight(offset), ancestor: overlay),
        bar.localToGlobal(bar.size.bottomRight(offset), ancestor: overlay),
      ),
      offset & overlay.size,
    );
    return position;
  }

  PopupMenuItem menuItem(IconData icon, String text, void Function() onTap) =>
      PopupMenuItem(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 4.0),
            Text(text),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final User? user = context.watch<IUserViewModel>().me;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          showMenu(
            context: context,
            position: buttonMenuPosition(context),
            items: [
              menuItem(
                Icons.logout,
                lang.abmelden,
                () => context.read<ISettingsViewModel>().logout(),
              ),
              if (!onSettingsPage)
                menuItem(
                  Icons.settings,
                  lang.einstellungen,
                  () => context
                      .read<IRouterService>()
                      .goNamed(RouteNames.settings),
                ),
            ],
          );
        },
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${user?.firstname ?? '-'} ${user?.lastname ?? ''}'),
                const SizedBox(height: 4.0),
                Text(
                    '${user?.role == null ? '' : lang.textFromRole(user!.role)}'
                    '${user?.canEditUnit == null ? '' : ' - ${user?.canEditUnit}'}'),
              ],
            ),
            const SizedBox(width: 8.0),
            const CircleAvatar(child: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
