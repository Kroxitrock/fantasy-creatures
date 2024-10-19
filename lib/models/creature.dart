import 'package:fantasy_creatures/models/armor.dart';
import 'package:fantasy_creatures/models/weapon.dart';

class Creature {
  String name;
  String? image;
  String? description;
  List<Weapon> weapons;
  List<ArmorType> armor;

  Creature(this.name, this.image, this.description, this.weapons, this.armor);
  Creature.fromJson(Map jsonObject)
      : name = "",
        weapons = [],
        armor = [] {
    name = jsonObject["name"];
    image = jsonObject["image"];
    description = jsonObject["description"];
    if (jsonObject["weapons"] != null && !jsonObject["weapons"].isEmpty) {
      weapons = jsonObject["weapons"]
          .map<Weapon>((weapon) => Weapon.fromString(weapon))
          .toList();
    }
    if (jsonObject["armor"] != null && !jsonObject["armor"].isEmpty) {
      weapons = jsonObject["armor"]
          .map<ArmorType>((armor) => Weapon.fromString(armor))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "description": description,
      "weapons": weapons.map((weapon) => weapon.toString()).toList(),
      "armor": armor.map((armorType) => armorType.toString()).toList(),
    };
  }
}
