import 'package:epro_frontend/model/user.dart';
import 'package:epro_frontend/util/extensions/app_localizations_extension.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem(this.user, {super.key});

  String getUnitString(int? id, BuildContext context) {
    final lang = context.lang();
    if (id == null) return '';
    try {
      var unit = context
          .read<IUnitViewModel>()
          .units
          .firstWhere((unit) => unit.id == id);
      return ' - ${lang.unit}: ${unit.name}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();

    return Card(
      child: ListTile(
        title: Text('${user.firstname} ${user.lastname} - ${user.email}'),
        subtitle: Text('${lang.role}: ${lang.textFromRole(user.role)}'
            '${getUnitString(user.canEditUnit, context)}'),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(lang.usersChangeRole),
            ),
            PopupMenuItem(
              child: Text(lang.usersNewUnit),
            ),
          ],
        ),
      ),
    );
  }
}
