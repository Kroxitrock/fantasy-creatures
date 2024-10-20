import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FightingCreatureWidget extends StatelessWidget {
  final creatureController = Get.find<CreatureController>();

  FightingCreatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu(
          dropdownMenuEntries: creatureController.creatures
              .map(
                (creature) => DropdownMenuEntry(
                  value: creature,
                  label: creature.name,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
