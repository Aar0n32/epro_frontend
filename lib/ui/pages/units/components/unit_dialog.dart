import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_unit_type.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/unit_create_dto.dart';
import 'package:epro_frontend/ui/shared/text_input_field.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitDialog extends StatefulWidget {
  final Unit parent;

  const UnitDialog(this.parent, {super.key});

  @override
  State<UnitDialog> createState() => _UnitDialogState();
}

class _UnitDialogState extends State<UnitDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _name;

  Future<void> _create() async {
    IUnitViewModel unitViewModel = context.read();
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      EUnitType type;
      switch (widget.parent.type) {
        case EUnitType.company:
          type = EUnitType.businessUnit;
          break;
        case EUnitType.businessUnit:
          type = EUnitType.unit;
          break;
        case EUnitType.unit:
          type = EUnitType.unit;
          break;
      }
      await unitViewModel
          .createUnit(UnitCreateDto(_name!, type, widget.parent.id));
      if (unitViewModel.loadingStateCreate != ELoadingState.error) {
        if (!context.mounted) return;
        unitViewModel.load();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IUnitViewModel unitViewModel = context.watch();

    return Stack(
      children: [
        AlertDialog(
          title: Text(lang.unitsDialogTitle),
          content: Form(
            key: _formKey,
            child: TextInputField(
              label: lang.name,
              value: _name,
              onChanged: (value) => setState(() => _name = value),
              validator: unitViewModel.nameValidator,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(lang.abbrechen)),
            TextButton(
              onPressed: _create,
              child: Text(lang.hinzufuegen),
            ),
          ],
        ),
        if (unitViewModel.loadingStateCreate == ELoadingState.loading)
          const Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
        if (unitViewModel.loadingStateCreate == ELoadingState.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
