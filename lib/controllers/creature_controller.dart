import 'package:fantasy_creatures/models/creature.dart';
import 'package:fantasy_creatures/services/creature_service.dart';
import 'package:get/get.dart';

class CreatureController {
  final creatureService = Get.find<CreatureService>();

  RxList<Creature> creatures = <Creature>[].obs;

  CreatureController() {
    creatures.value = creatureService.creatures;
  }

  Creature? getCreature(String uuid) =>
      creatures.firstWhereOrNull((creature) => creature.uuid == uuid);

  void addCreature(Creature creature) {
    creatures.add(creature);
    creatureService.addCreature(creature);
    creatures.refresh();
  }

  void updateCreature(Creature creature) {
    creatures
        .firstWhere(
          (element) => element.uuid == creature.uuid,
        )
        .copy(creature);
    creatureService.updateCreature(creature);
    creatures.refresh();
  }

  deleteCreature(Creature creature) {
    creatures.remove(creature);
    creatureService.deleteCreature(creature);
  }
}
