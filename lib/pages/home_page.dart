import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/widgets/creature_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final creatureController = Get.find<CreatureController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: Obx(
              () => CreatureListWidget(creatureController.creatures.toList())),
        ),
      ),
    );
  }
}
