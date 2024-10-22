import 'dart:convert';

import 'package:fantasy_creatures/models/creature.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class CreatureService {
  final storage = Hive.box("storage");

  get creatures {
    List<Creature> creatures = List.empty(growable: true);

    final creatureJSON = storage.get("creatures");
    if (creatureJSON == null) {
      return creatures;
    }

    final Iterable decodedCreatures = jsonDecode(creatureJSON);

    creatures.addAll(
      List<Creature>.from(
        decodedCreatures.map((model) => Creature.fromJson(model)),
      ),
    );

    return creatures;
  }

  addCreature(Creature creature) {
    storage.put("creatures", jsonEncode(creatures..add(creature)));
  }

  updateCreature(Creature creature) {
    final updatedList = creatures;

    updatedList
        .firstWhere((element) => element.uuid == creature.uuid)
        .copy(creature);
    storage.put("creatures", jsonEncode(updatedList));
  }

  deleteCreature(Creature creature) {
    storage.put("creatures",
        jsonEncode(creatures.where((c) => creature.uuid != c.uuid).toList()));
  }
}
