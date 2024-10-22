import 'dart:convert';

import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/widgets/navigation_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatureDetailsPage extends StatelessWidget {
  final creatureController = Get.find<CreatureController>();

  CreatureDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parentSelectedIndex = Get.arguments ?? 1;
    final String? creatureUuid = Get.parameters['uuid'];

    if (creatureUuid == null || creatureUuid.isEmpty) {
      throw Exception("No creature UUID provided!");
    }

    final creature = creatureController.getCreature(creatureUuid);

    if (creature == null) {
      throw Exception("No creature with spcecified UUID found!");
    }

    return NavigationScaffoldWidget(
        Card(
          child: ListView(
            children: [
              ListTile(
                title: Text(creature.name),
              ),
              if (creature.image != null)
                Image.memory(base64Decode(creature.image!)),
              const Text("Description"),
              Text(creature.description ?? ""),
              Text("Size: ${creature.size.name}"),
              Text(
                  "Weapons: ${creature.weapons.map((weapon) => weapon.name).join(", ")}"),
              Text(
                  "Armor: ${creature.armor.map((armor) => armor.name).join(", ")}"),
            ],
          ),
        ),
        parentSelectedIndex);
  }
}
