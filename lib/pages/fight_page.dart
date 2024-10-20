import 'package:fantasy_creatures/controllers/fight_controller.dart';
import 'package:fantasy_creatures/widgets/fighting_creature_widget.dart';
import 'package:fantasy_creatures/widgets/navigation_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FightPage extends StatelessWidget {
  final fightController = Get.find<FightController>();

  FightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationScaffoldWidget(
      Obx(
        () => ListView(
          children: [
            Row(
              children: [
                FightingCreatureWidget(1),
                ElevatedButton(
                    onPressed: fightController.fight,
                    child: const Text("Fight")),
                FightingCreatureWidget(2),
              ],
            ),
            ...fightController.fightRecords.map((record) => Card(
                  child: Text(record),
                ))
          ],
        ),
      ),
      1,
    );
  }
}
