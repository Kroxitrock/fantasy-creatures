import 'package:fantasy_creatures/models/armor.dart';
import 'package:fantasy_creatures/models/creature_size.dart';
import 'package:fantasy_creatures/models/weapon.dart';
import 'package:uuid/uuid.dart';

class Creature {
  static const uuidGenerator = Uuid();

  String uuid;
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
      this.armor)
      : uuid = uuidGenerator.v4();

  Creature.unknown()
      : uuid = uuidGenerator.v4(),
        name = "Uknown",
        size = CreatureSize.small,
        weapons = [],
        armor = [];

  Creature.fromJson(Map jsonObject)
      : uuid = uuidGenerator.v4(),
        name = "",
        size = CreatureSize.small,
        weapons = [],
        armor = [] {
    uuid = uuidGenerator.v4();
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
      "uuid": uuid,
      "name": name,
      "image": image,
      "description": description,
      "size": size.toString(),
      "weapons": weapons.map((weapon) => weapon.toString()).toList(),
      "armor": armor.map((armorType) => armorType.toString()).toList(),
    };
  }

  void copy(Creature other) {
    uuid = other.uuid;
    name = other.name;
    image = other.image;
    description = other.description;
    size = other.size;
    weapons = other.weapons;
    armor = other.armor;
  }
}
