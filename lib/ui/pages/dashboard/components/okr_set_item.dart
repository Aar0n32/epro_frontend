import 'package:epro_frontend/configs/app_styles.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/ui/pages/dashboard/components/key_result_item.dart';
import 'package:epro_frontend/ui/shared/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OkrSetItem extends StatelessWidget {
  final OkrSet okrSet;
  final bool showHeader;

  const OkrSetItem({
    super.key,
    required this.okrSet,
    required this.showHeader,
  });

  List<Widget> get children {
    List<Widget> result = [];
    result.addAll(okrSet.belongsToKeyResults.map((e) => KeyResultItem(e)));
    for (int i = 0; i < result.length; i += 2) {
      result.insert(i, const Divider());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    AppStyles appStyles = context.watch();
    return Column(
      children: [
        if (showHeader)
          Stack(
            children: [
              const Divider(),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                color: appStyles.colors.background,
                child: Text(okrSet.unit.name),
              ),
            ],
          ),
        Card(
          child: ExpansionTile(
            title: ProgressBar(title: okrSet.objective.name),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
