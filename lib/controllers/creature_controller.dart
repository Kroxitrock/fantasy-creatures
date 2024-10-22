import 'package:fantasy_creatures/models/creature.dart';
import 'package:fantasy_creatures/services/creature_service.dart';
import 'package:get/get.dart';

class CreatureController {
  final creatureService = Get.find<CreatureService>();

  RxList<Creature> creatures;

  CreatureController() : creatures = RxList.empty(growable: true) {
    creatures.value = creatureService.creatures;
  }

  Creature? getCreature(String uuid) =>
      creatures.firstWhereOrNull((creature) => creature.uuid == uuid);

  void addCreature(Creature creature) {
    creatures.add(creature);
    creatureService.addCreature(creature);
  }

  delete(Creature creature) {
    creatures.remove(creature);
    creatureService.removeCreature(creature);
  }
}
