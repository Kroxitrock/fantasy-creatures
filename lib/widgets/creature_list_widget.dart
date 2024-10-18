import 'package:fantasy_creatures/models/creature.dart';
import 'package:fantasy_creatures/widgets/creature_card_widget.dart';
import 'package:flutter/material.dart';

class CreatureListWidget extends StatelessWidget {
  final List<Creature> creatures;

  const CreatureListWidget(this.creatures, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: buildCreatureCardList(),
    );
  }

  List<Widget> buildCreatureCardList() {
    return creatures.map((creature) => CreatureCardWidget(creature)).toList();
  }
}
