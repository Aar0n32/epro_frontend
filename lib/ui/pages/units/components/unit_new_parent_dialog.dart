import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/ui/shared/dropdown_field.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitNewParentDialog extends StatefulWidget {
  final Unit unit;
  const UnitNewParentDialog(this.unit, {super.key});

  @override
  State<UnitNewParentDialog> createState() => _UnitNewParentDialogState();
}

class _UnitNewParentDialogState extends State<UnitNewParentDialog> {
  final _formKey = GlobalKey<FormState>();
  Unit? _parent;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IUnitViewModel unitViewModel = context.watch();

    Future<void> move() async {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        await unitViewModel
            .move(widget.unit.id, _parent!.id);
        if (unitViewModel.loadingStateMove != ELoadingState.error) {
          if (!context.mounted) return;
          unitViewModel.load();
          Navigator.of(context).pop();
        }
      }
    }

    return Stack(
      children: [
        AlertDialog(
          title: Text(lang.unitsDialogTitle),
          content: Form(
            key: _formKey,
            child: Expanded(
              child: DropdownField<Unit>(
                label: lang.unit,
                value: _parent,
                disabled: false,
                items: unitViewModel.units,
                onChanged: (value) {
                  if (value == null) return '';
                  _parent = value;
                  return value.name;
                },
                validator: (_) => unitViewModel.unitParent(_parent!, widget.unit),
                itemMappingHandler: (e) => Text('${e.id} | ${e.name}'),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(lang.abbrechen)),
            TextButton(
              onPressed: move,
              child: const Text('Umhängen'),
            ),
          ],
        ),
        if (unitViewModel.loadingStateMove == ELoadingState.loading)
          const Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
        if (unitViewModel.loadingStateMove == ELoadingState.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
