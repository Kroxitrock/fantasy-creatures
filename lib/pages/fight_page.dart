import 'package:fantasy_creatures/widgets/fighting_creature_widget.dart';
import 'package:fantasy_creatures/widgets/navigation_scaffold_widget.dart';
import 'package:flutter/material.dart';

class FightPage extends StatelessWidget {
  const FightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationScaffoldWidget(
        ListView(
          children: [
            Row(
              children: [
                FightingCreatureWidget(),
                ElevatedButton(onPressed: fight, child: const Text("Fight")),
                FightingCreatureWidget(),
              ],
            )
          ],
        ),
        1);
  }

  void fight() {}
}
