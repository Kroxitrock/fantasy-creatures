import 'package:fantasy_creatures/models/weapon.dart';

class Creature {
  String name;
  String? image;
  String? description;
  List<Weapon> weapons;

  Creature(this.name, this.image, this.description, this.weapons);
  Creature.fromJson(Map jsonObject)
      : name = "",
        weapons = [] {
    name = jsonObject["name"];
    image = jsonObject["image"];
    description = jsonObject["description"];
    if (jsonObject["weapons"] != null && !jsonObject["weapons"].isEmpty) {
      weapons = jsonObject["weapons"]
          .map<Weapon>((weapon) => Weapon.fromString(weapon))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "description": description,
      "weapons": weapons.map((weapon) => weapon.toString()).toList(),
    };
  }
}
