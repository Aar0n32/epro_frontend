import 'package:epro_frontend/constants/enums/e_loading_state.dart';
import 'package:epro_frontend/ui/pages/units/components/unit_item.dart';
import 'package:epro_frontend/ui/shared/error_card.dart';
import 'package:epro_frontend/util/extensions/context_lang_extension.dart';
import 'package:epro_frontend/view_models/unit/i_unit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_image_paths.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({super.key});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<IUnitViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final IUnitViewModel unitViewModel = context.watch();

    final Widget? content;

    switch(unitViewModel.loadingState){
      case ELoadingState.initial:
      case ELoadingState.loading:
        content = const Center(child: CircularProgressIndicator());
      case ELoadingState.done:
        content = Card(child: UnitItem(unitViewModel.companyUnit));
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
            Text(lang.unitsTitle),
          ],
        ),
        centerTitle: false,
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