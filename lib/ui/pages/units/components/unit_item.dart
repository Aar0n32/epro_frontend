import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/ui/pages/units/components/unit_dialog.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitItem extends StatefulWidget {
  final Unit unit;

  const UnitItem(this.unit, {super.key});

  @override
  State<UnitItem> createState() => _UnitItemState();
}

class _UnitItemState extends State<UnitItem> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IUnitViewModel unitViewModel = context.watch();

    final children =
        unitViewModel.getChildUnits(widget.unit.id);

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(
          _expanded ? Icons.expand_less : Icons.expand_more,
          color: children.isEmpty
              ? Colors.transparent
              : null,
        ),
        onExpansionChanged: (value) => setState(() => _expanded = value),
        title: Text(widget.unit.name),
        initiallyExpanded: true,
        collapsedIconColor: Theme.of(context).colorScheme.onSurface,
        collapsedTextColor: Theme.of(context).colorScheme.onSurface,
        iconColor: Theme.of(context).colorScheme.onSurface,
        textColor: Theme.of(context).colorScheme.onSurface,
        trailing: PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case EUnitMenu.delete:
                break;
              case EUnitMenu.rename:
                break;
              case EUnitMenu.add:
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => UnitDialog(widget.unit));
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: EUnitMenu.delete,
              child: Text(lang.loeschen),
            ),
            PopupMenuItem(
              value: EUnitMenu.rename,
              child: Text(lang.rename),
            ),
            PopupMenuItem(
              value: EUnitMenu.add,
              child: Text(lang.addUnit),
            ),
          ],
        ),
        children: children
            .map((unit) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: UnitItem(unit),
                ))
            .toList(),
      ),
    );
  }
}

enum EUnitMenu { delete, rename, add }
