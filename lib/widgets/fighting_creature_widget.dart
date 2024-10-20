import 'dart:convert';

import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/controllers/fight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FightingCreatureWidget extends StatelessWidget {
  final creatureController = Get.find<CreatureController>();
  final fightController = Get.find<FightController>();

  final int fighterNumber;

  FightingCreatureWidget(this.fighterNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DropdownMenu(
            onSelected: (fighter) =>
                fightController.setFighter(fighterNumber, fighter!),
            dropdownMenuEntries: creatureController.creatures
                .map(
                  (creature) => DropdownMenuEntry(
                    value: creature,
                    label: creature.name,
                  ),
                )
                .toList(),
          ),
          Obx(getFighterImage),
        ],
      ),
    );
  }

  Widget getFighterImage() {
    final fighter = fightController.getFighter(fighterNumber);

    if (fighter.image != null) {
      return Image.memory(base64Decode(fighter.image!));
    }

    return const Card(
      color: Colors.grey,
    );
  }
}
