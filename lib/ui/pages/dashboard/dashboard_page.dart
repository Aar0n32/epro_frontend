import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    int lastUnitId = -1;
    bool showHeader = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(AssetImagePaths.okrLogoSmall),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
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
