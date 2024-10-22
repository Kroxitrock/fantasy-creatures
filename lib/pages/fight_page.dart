import 'package:fantasy_creatures/controllers/fight_controller.dart';
import 'package:fantasy_creatures/widgets/fighting_creature_card_widget.dart';
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
            GridView.count(
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                FightingCreatureCardWidget(1),
                FightingCreatureCardWidget(2),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: fightController.fight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: const Size(100, 50),
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                child: const Text(
                  "Fight",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ...fightController.fightRecords.map(
              (record) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(record),
                ),
              ),
            )
          ],
        ),
      ),
      1,
    );
  }
}
