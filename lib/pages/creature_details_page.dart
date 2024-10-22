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
    final width = MediaQuery.of(context).size.width;

    if (creatureUuid == null || creatureUuid.isEmpty) {
      throw Exception("No creature UUID provided!");
    }

    final creature = creatureController.getCreature(creatureUuid);
    if (creature == null) {
      throw Exception("No creature with specified UUID found!");
    }

    return NavigationScaffoldWidget(
      Card(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: IntrinsicWidth(
                  child: ListTile(
                    title: Text(
                      creature.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              if (creature.image != null)
                Center(
                  child: FractionallySizedBox(
                    widthFactor: width < 641 ? 0.4 : 0.2,
                    child: Image.memory(base64Decode(creature.image!)),
                  ),
                ),
              const Text(
                "Description:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(creature.description ?? ""),
              Text(
                "Size: ${creature.size.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Weapons: ${creature.weapons.isEmpty ? "None" : creature.weapons.map((weapon) => weapon.name).join(", ")}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Armor: ${creature.armor.isEmpty ? "None" : creature.armor.map((armor) => armor.name).join(", ")}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => print("Edit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => print("Delete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      parentSelectedIndex,
    );
  }
}
