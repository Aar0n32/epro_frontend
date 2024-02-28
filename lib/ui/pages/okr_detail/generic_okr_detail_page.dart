import 'dart:async';

import 'package:epro_frontend/constants/asset_image_paths.dart';
import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/constants/enums/e_okr_set_detail_mode.dart';
import 'package:epro_frontend/constants/route_names.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/services/router/i_router_service.dart';
import 'package:epro_frontend/ui/pages/okr_detail/components/key_result_detail.dart';
import 'package:epro_frontend/ui/pages/settings/components/user_settings_item.dart';
import 'package:epro_frontend/ui/shared/dropdown_field.dart';
import 'package:epro_frontend/ui/shared/error_card.dart';
import 'package:epro_frontend/ui/shared/progress_bar.dart';
import 'package:epro_frontend/ui/shared/text_input_field.dart';
import 'package:epro_frontend/view_models/okr_set/i_okr_set_detail_view_model.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenericOkrDetailPage extends StatefulWidget {
  final String? id;
  final EOkrSetDetailMode mode;

  const GenericOkrDetailPage(this.id, this.mode, {super.key});

  @override
  State<GenericOkrDetailPage> createState() => _GenericOkrDetailPageState();
}

class _GenericOkrDetailPageState extends State<GenericOkrDetailPage> {
  final _formKey = GlobalKey<FormState>();

  bool get _isEditingModeDisabled {
    switch (widget.mode) {
      case EOkrSetDetailMode.read:
        return true;
      default:
        return false;
    }
  }

  String get _title {
    switch (widget.mode) {
      case EOkrSetDetailMode.read:
        return 'Okr-Set Details';
      case EOkrSetDetailMode.edit:
        return 'Okr-Set Bearbeiten';
      case EOkrSetDetailMode.create:
        return 'Okr-Set Erstellen';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var okrSetDetailViewModel = context.read<IOkrSetDetailViewModel>();
      OkrSet? okrSet;
      if (widget.id != null) {
        await okrSetDetailViewModel.load(int.parse(widget.id!));
        okrSet = okrSetDetailViewModel.okrSet;
      }
      if (!context.mounted) return;
      await context.read<IUnitViewModel>().load();

      okrSetDetailViewModel.objectiveZiel = okrSet?.objective.name;
      okrSetDetailViewModel.objectiveBeschreibung =
          okrSet?.objective.description;
      okrSetDetailViewModel.unit = okrSet?.unit;
      okrSetDetailViewModel.paysInto = okrSet?.paysIntoKeyResults?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IOkrSetDetailViewModel okrSetDetailViewModel = context.watch();
    final IUnitViewModel unitViewModel = context.watch();

    Widget buttons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.mode == EOkrSetDetailMode.read)
          ElevatedButton(
            onPressed: () async => await context
                .read<IRouterService>()
                .pushNamed(RouteNames.edit,
                    params: {'id': widget.id!}, extra: EOkrSetDetailMode.edit),
            child: const Text('Bearbeiten'),
          ),
        if (widget.mode != EOkrSetDetailMode.read)
          ElevatedButton(
            onPressed: () => context.read<IRouterService>().pop(),
            child: const Text('Abbrechen'),
          ),
        if (widget.mode != EOkrSetDetailMode.read) const SizedBox(width: 8.0),
        if (widget.mode == EOkrSetDetailMode.edit)
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                await okrSetDetailViewModel.edit();
                if (okrSetDetailViewModel.loadingStateEdit !=
                    ELoadingState.error) {
                  if (!context.mounted) return;
                  unawaited(okrSetDetailViewModel.load(int.parse(widget.id!)));
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('Speichern'),
          ),
        if (widget.mode == EOkrSetDetailMode.create)
          ElevatedButton(
            onPressed: () async => await context
                .read<IRouterService>()
                .pushNamed(RouteNames.edit,
                    params: {'id': widget.id!}, extra: EOkrSetDetailMode.edit),
            child: const Text('Erstellen'),
          ),
      ],
    );

    Widget? content;

    if (okrSetDetailViewModel.loadingState == ELoadingState.error ||
        unitViewModel.loadingState == ELoadingState.error) {
      content = const ErrorCard();
    } else if (okrSetDetailViewModel.loadingState == ELoadingState.done &&
        unitViewModel.loadingState == ELoadingState.done &&
        okrSetDetailViewModel.okrSet != null) {
      content = Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buttons,
            TextInputField(
              label: 'Ziel',
              value: okrSetDetailViewModel.objectiveZiel,
              noPadding: widget.mode == EOkrSetDetailMode.read,
              isEditingModeDisabled: _isEditingModeDisabled,
              onChanged: (value) => okrSetDetailViewModel.objectiveZiel = value,
            ),
            TextInputField(
              label: 'Beschreibung',
              value: okrSetDetailViewModel.objectiveBeschreibung,
              noPadding: widget.mode == EOkrSetDetailMode.read,
              isEditingModeDisabled: _isEditingModeDisabled,
              onChanged: (value) =>
                  okrSetDetailViewModel.objectiveBeschreibung = value,
            ),
            widget.mode == EOkrSetDetailMode.create
                ? DropdownField<OkrSetUnit>(
                    label: 'Unit',
                    value: okrSetDetailViewModel.unit,
                    disabled: false,
                    items: [],
                    onChanged: (value) {
                      if (value == null) return '';
                      okrSetDetailViewModel.unit = value;
                      return value.name;
                    },
                    //validator: userViewModel.unitValidator,
                    itemMappingHandler: (e) => Text('${e.id} | ${e.name}'),
                  )
                : TextInputField(
                    label: 'Unit',
                    value: okrSetDetailViewModel.unit?.name,
                    noPadding: true,
                    isEditingModeDisabled: true,
                  ),
            TextInputField(
              label: 'Zahlt ein auf',
              value: okrSetDetailViewModel.paysInto == null
                  ? (widget.mode == EOkrSetDetailMode.read ? '-' : null)
                  : okrSetDetailViewModel.paysInto.toString(),
              noPadding: widget.mode == EOkrSetDetailMode.read,
              isEditingModeDisabled: _isEditingModeDisabled,
              onChanged: (value) => okrSetDetailViewModel.paysInto = int.tryParse(value),
            ),
            if (widget.mode != EOkrSetDetailMode.create)
              ProgressBar(okrSetDetailViewModel.okrSet!.progressPercentage),
            const SizedBox(height: 8.0),
            Text('Key Results', style: Theme.of(context).textTheme.titleMedium),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => KeyResultDetailItem(
                    okrSetDetailViewModel.okrSet!.belongsToKeyResults[index]),
                itemCount:
                    okrSetDetailViewModel.okrSet!.belongsToKeyResults.length,
              ),
            ),
          ],
        ),
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
            Text(_title),
          ],
        ),
        centerTitle: false,
        actions: const [UserSettingsItem()],
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
