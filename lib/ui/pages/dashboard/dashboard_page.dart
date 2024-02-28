import 'package:epro_frontend/ui/pages/settings/components/user_settings_item.dart';
import 'package:epro_frontend/view_models/user/i_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/okr_set_item.dart';
import '../../../constants/asset_image_paths.dart';
import '../../../constants/enums/e_progress_type.dart';
import '../../../constants/enums/e_unit_type.dart';
import '../../../model/key_result.dart';
import '../../../model/okr_set.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)  async{
      await context.read<IUserViewModel>().loadMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    int lastUnitId = -1;
    bool showHeader = false;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(AssetImagePaths.okrLogoSmall, height: 56,),
            ),
            const Text('Dashboard'),
          ],
        ),
        centerTitle: false,
        actions: const [UserSettingsItem()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _okrSets.length,
            itemBuilder: (context, index) {
              var okrSet = _okrSets[index];
              if (okrSet.unit.id == lastUnitId) {
                showHeader = false;
              } else {
                showHeader = true;
              }
              lastUnitId = okrSet.unit.id;
              return OkrSetItem(
                okrSet: okrSet,
                showHeader: showHeader,
              );
            },
          ),
        ),
      ),
    );
  }

  final List<OkrSet> _okrSets = const [
    OkrSet(
      1,
      OkrSetUnit(1, 'Company', EUnitType.company),
      OkrSetObjective(1, 'Okr Objective', 'Beschreibung'),
      [
        KeyResult(
          1,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
        KeyResult(
          2,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
        KeyResult(
          3,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
      ],
    ),
    OkrSet(
      1,
      OkrSetUnit(1, 'Company', EUnitType.company),
      OkrSetObjective(1, 'Okr Objective', 'Beschreibung'),
      [
        KeyResult(
          1,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
        KeyResult(
          2,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
        KeyResult(
          3,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
      ],
    ),
    OkrSet(
      1,
      OkrSetUnit(2, 'BuisnessUnit', EUnitType.company),
      OkrSetObjective(1, 'Okr Objective', 'Beschreibung'),
      [
        KeyResult(
          1,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
        KeyResult(
          2,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
        KeyResult(
          3,
          'name',
          'description',
          0,
          10,
          EProgressType.numeric,
          1,
          [],
        ),
      ],
    ),
  ];
}
