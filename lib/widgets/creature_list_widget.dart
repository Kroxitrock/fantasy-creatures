import 'package:fantasy_creatures/models/creature.dart';
import 'package:fantasy_creatures/widgets/creature_card_widget.dart';
import 'package:flutter/material.dart';

class CreatureListWidget extends StatelessWidget {
  final List<Creature> creatures;

  const CreatureListWidget(this.creatures, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int columns = 5;

    if (width < 641) {
      columns = 1;
    } else if (width < 1008) {
      columns = 3;
    }

    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      children: buildCreatureCardList(),
    );
  }

  List<Widget> buildCreatureCardList() {
    return creatures.map((creature) => CreatureCardWidget(creature)).toList();
  }
}
