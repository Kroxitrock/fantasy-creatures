import 'dart:convert';

import 'package:fantasy_creatures/models/creature.dart';
import 'package:flutter/material.dart';

class CreatureCardWidget extends StatelessWidget {
  final Creature creature;

  const CreatureCardWidget(this.creature, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(creature.name),
          if (creature.image != null)
            Image.memory(base64Decode(creature.image!)),
          if (creature.description != null) Text(creature.description!)
        ],
      ),
    );
  }
}
