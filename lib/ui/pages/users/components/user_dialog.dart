import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_role.dart';
import 'package:epro_frontend/constants/enums/e_unit_type.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/ui/shared/text_input_field.dart';
import 'package:epro_frontend/ui/shared/dropdown_field.dart';
import 'package:epro_frontend/util/extensions/app_localizations_extension.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({super.key});

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IUserViewModel userViewModel = context.watch();
    final List<Unit?> units = [null];
    units.addAll(context
        .watch<IUnitViewModel>()
        .units
        .where((unit) => unit.type == EUnitType.businessUnit));

    return Stack(
      children: [
        AlertDialog(
          title: Text(lang.usersCreateTitle),
          content: SizedBox(
            width: 500,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextInputField(
                          label: lang.vorname,
                          value: userViewModel.dialogFirstname,
                          onChanged: (value) =>
                              userViewModel.dialogFirstname = value,
                          validator: userViewModel.nameValidator,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: TextInputField(
                          label: lang.nachname,
                          value: userViewModel.dialogLastname,
                          onChanged: (value) =>
                              userViewModel.dialogLastname = value,
                          validator: userViewModel.nameValidator,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextInputField(
                          label: lang.email,
                          value: userViewModel.dialogMail,
                          onChanged: (value) =>
                              userViewModel.dialogMail = value,
                          validator: userViewModel.mailValidator,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: TextInputField(
                          label: lang.passwort,
                          value: userViewModel.dialogPassword,
                          onChanged: (value) =>
                              userViewModel.dialogPassword = value,
                          validator: userViewModel.passwordValidator,
                          obscureText: _obscureText,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                                      _obscureText = !_obscureText;
                                    }),
                            icon: _obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownField<ERole>(
                          label: lang.role,
                          value: userViewModel.dialogRole,
                          disabled: false,
                          items: ERole.values,
                          onChanged: (value) {
                            if (value == null) return '';
                            userViewModel.dialogRole = value;
                            return value.name;
                          },
                          itemMappingHandler: (ERole e) =>
                              Text(lang.textFromRole(e)),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: DropdownField<Unit?>(
                          label: lang.unit,
                          value: userViewModel.dialogUnit,
                          disabled: false,
                          items: units,
                          onChanged: (value) {
                            if (value == null) return '';
                            userViewModel.dialogUnit = value;
                            return value.name;
                          },
                          validator: userViewModel.unitValidator,
                          itemMappingHandler: (e) => e == null
                              ? Text(lang.usersNoUnit)
                              : Text('${e.id} | ${e.name}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(lang.abbrechen)),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  await userViewModel.createUser();
                  if (userViewModel.loadingStateAdd != ELoadingState.error) {
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Text(lang.speichern),
            ),
          ],
        ),
        if (userViewModel.loadingStateAdd == ELoadingState.loading)
          const Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
        if (userViewModel.loadingStateAdd == ELoadingState.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
