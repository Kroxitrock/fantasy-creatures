import 'package:fantasy_creatures/widgets/navigation_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatureDetailsPage extends StatelessWidget {
  const CreatureDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parentSelectedIndex = Get.arguments ?? 1;

    return NavigationScaffoldWidget(
        const Text("hello world"), parentSelectedIndex);
  }
}
