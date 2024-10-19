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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
              title: Center(
                child: Text(creature.name),
              ),
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          if (creature.image != null)
            Expanded(
              child: Image.memory(
                base64Decode(creature.image!),
              ),
            ),
        ],
      ),
    );
  }
}
