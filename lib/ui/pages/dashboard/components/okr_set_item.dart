import 'package:epro_frontend/configs/app_styles.dart';
import 'package:epro_frontend/constants/enums/e_okr_set_detail_mode.dart';
import 'package:epro_frontend/constants/route_names.dart';
import 'package:epro_frontend/model/okr_set.dart';
import 'package:epro_frontend/services/router/i_router_service.dart';
import 'package:epro_frontend/ui/pages/dashboard/components/key_result_item.dart';
import 'package:epro_frontend/ui/shared/progress_bar_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OkrSetItem extends StatefulWidget {
  final OkrSet okrSet;
  final bool showHeader;

  const OkrSetItem({
    super.key,
    required this.okrSet,
    required this.showHeader,
  });

  @override
  State<OkrSetItem> createState() => _OkrSetItemState();
}

class _OkrSetItemState extends State<OkrSetItem> {
  bool _expanded = false;

  List<Widget> get _children {
    List<Widget> result = [];
    result
        .addAll(widget.okrSet.belongsToKeyResults.map((e) => KeyResultItem(e)));
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
        if (widget.showHeader)
          Stack(
            children: [
              const Divider(),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                color: appStyles.colors.background,
                child: Text(widget.okrSet.unit.name),
              ),
            ],
          ),
        Card(
          child: ExpansionTile(
            leading: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
              color: _children.isEmpty ? Colors.transparent : null,
            ),
            onExpansionChanged: (value) => setState(() => _expanded = value),
            title: ProgressBarTile(
              title: widget.okrSet.objective.name,
              value: widget.okrSet.progressPercentage,
            ),
            collapsedIconColor: Theme.of(context).colorScheme.onSurface,
            collapsedTextColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            textColor: Theme.of(context).colorScheme.onSurface,
            trailing: IconButton(
              onPressed: () async => await context
                  .read<IRouterService>()
                  .pushNamed(RouteNames.detail, params: {
                'id': widget.okrSet.id.toString(),
              }, extra: EOkrSetDetailMode.read),
              icon: const Icon(Icons.navigate_next),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: _children,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
