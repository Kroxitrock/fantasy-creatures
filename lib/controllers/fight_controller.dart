import 'dart:math';

import 'package:fantasy_creatures/models/creature.dart';
import 'package:get/get.dart';

class FightController {
  final Rxn<Creature> fighterOne;
  final Rxn<Creature> fighterTwo;
  final RxList<String> fightRecords;

  FightController()
      : fighterOne = Rxn(Creature.unknown()),
        fighterTwo = Rxn(Creature.unknown()),
        fightRecords = RxList.empty(growable: true);

  setFighter(int fighterNumber, Creature fighter) {
    final fighterToUpdate = getObservableFighter(fighterNumber);

    fighterToUpdate.update((updateable) => updateable!.copy(fighter));
  }

  Creature getFighter(int fighterNumber) =>
      getObservableFighter(fighterNumber).value!;

  Rxn<Creature> getObservableFighter(int fighterNumber) =>
      fighterNumber == 1 ? fighterOne : fighterTwo;

  fight() {
    fightRecords.clear();
    if (fighterOne.value!.weapons.isEmpty &&
        fighterTwo.value!.weapons.isEmpty) {
      noWeaponsMessage();
      return;
    }
    final rng = Random();
    final leftFighter = fighterOne.value!;
    int leftFighterHealth =
        rng.nextInt(leftFighter.size.maxHealth - leftFighter.size.minHealth) +
            leftFighter.size.minHealth;
    final rightFighter = fighterTwo.value!;
    int rightFighterHealth =
        rng.nextInt(rightFighter.size.maxHealth - rightFighter.size.minHealth) +
            rightFighter.size.minHealth;
    battleStartMessage(leftFighterHealth, rightFighterHealth);

    var roundNumber = 0;

    while (leftFighterHealth > 0 && rightFighterHealth > 0) {
      roundNumber++;
      var leftFighterHit = 0;
      var rightFighterHit = 0;
      for (var weapon in leftFighter.weapons) {
        leftFighterHit +=
            rng.nextInt(weapon.maxDamage - weapon.minDamage) + weapon.minDamage;
      }
      for (var weapon in rightFighter.weapons) {
        rightFighterHit +=
            rng.nextInt(weapon.maxDamage - weapon.minDamage) + weapon.minDamage;
      }

      leftFighterHit -= rightFighter.armorClass;
      if (leftFighterHit < 0) leftFighterHit = 0;
      rightFighterHit -= leftFighter.armorClass;
      if (rightFighterHit < 0) rightFighterHit = 0;

      leftFighterHealth -= rightFighterHit;
      if (leftFighterHealth < 0) leftFighterHealth = 0;
      rightFighterHealth -= leftFighterHit;
      if (rightFighterHealth < 0) rightFighterHealth = 0;

      roundMessage(roundNumber, leftFighterHit, rightFighterHit,
          leftFighterHealth, rightFighterHealth);
    }

    if (leftFighterHealth == 0 && rightFighterHealth == 0) {
      drawMessage();
      return;
    }

    if (leftFighterHealth == 0) {
      rightVictoryMessage();
      return;
    }

    leftVictoryMessage();
  }

  noWeaponsMessage() {
    fightRecords.add(
        "There is going to be no fight tonight, folks! Someone forgot to send us armed creatures... No refunds, though!");
  }

  battleStartMessage(
    int leftFighterStartingHealth,
    int rightFighterStartingHealth,
  ) {
    fightRecords.add(
        "In the left corner, boasting $leftFighterStartingHealth hit points, please give a warm applouse to ${fighterOne.value!.name}! And their opponent in the right corner with $rightFighterStartingHealth health points, give it up for ${fighterTwo.value!.name}");
  }

  roundMessage(
    int roundNumber,
    int leftFighterHit,
    int rightFighterHit,
    int leftFighterHealth,
    int rightFighterHealth,
  ) {
    fightRecords.add(
        "Round $roundNumber: The ${fighterOne.value!.name} on the left dealt $leftFighterHit damage, leaving their opponent with $rightFighterHealth. For that, they recieved $rightFighterHit damage from the ${fighterTwo.value!.name} on the right, leaving them with $leftFighterHealth health points.");
  }

  drawMessage() {
    fightRecords.add(
        "It's a draw! Stop booing, I can't be blamed, jeez... Still no refunds!!!");
  }

  rightVictoryMessage() {
    fightRecords.add(
        "Victory for the ${fighterTwo.value!.name} on the right! They sure will be appearing again on the arena. Buy your thickets now, before prices go up!");
  }

  leftVictoryMessage() {
    fightRecords.add(
        "Victory for the ${fighterOne.value!.name} on the left! They sure will be appearing again on the arena. Buy your thickets now, before prices go up!");
  }
}
