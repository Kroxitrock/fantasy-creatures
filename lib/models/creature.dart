import 'package:fantasy_creatures/models/armor.dart';
import 'package:fantasy_creatures/models/creature_size.dart';
import 'package:fantasy_creatures/models/weapon.dart';

class Creature {
  String name;
  String? image;
  String? description;
  CreatureSize size;
  List<Weapon> weapons;
  List<ArmorType> armor;

  int get armorClass {
    var armorClass = 0;

    for (final armorType in armor) {
      armorClass += armorType.armorValue;
    }

    return armorClass;
  }

  Creature(this.name, this.image, this.description, this.size, this.weapons,
      this.armor);

  Creature.unknown()
      : name = "Uknown",
        size = CreatureSize.small,
        weapons = [],
        armor = [];

  Creature.fromJson(Map jsonObject)
      : name = "",
        size = CreatureSize.small,
        weapons = [],
        armor = [] {
    name = jsonObject["name"];
    image = jsonObject["image"];
    description = jsonObject["description"];
    if (jsonObject["size"] != null) {
      size = CreatureSize.fromString(jsonObject["size"]);
    }
    if (jsonObject["weapons"] != null && !jsonObject["weapons"].isEmpty) {
      weapons = jsonObject["weapons"]
          .map<Weapon>((weapon) => Weapon.fromString(weapon))
          .toList();
    }
    if (jsonObject["armor"] != null && !jsonObject["armor"].isEmpty) {
      armor = jsonObject["armor"]
          .map<ArmorType>((armor) => ArmorType.fromString(armor))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "description": description,
      "size": size.toString(),
      "weapons": weapons.map((weapon) => weapon.toString()).toList(),
      "armor": armor.map((armorType) => armorType.toString()).toList(),
    };
  }

  void copy(Creature other) {
    name = other.name;
    image = other.image;
    description = other.description;
    size = other.size;
    weapons = other.weapons;
    armor = other.armor;
  }
}
