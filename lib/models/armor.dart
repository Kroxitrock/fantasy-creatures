enum ArmorType {
  plate(name: "Plate", armorValue: 4),
  mail(name: "Mail", armorValue: 3),
  leather(name: "Leather", armorValue: 2),
  cloth(name: "Cloth", armorValue: 1),
  scales(name: "Scales", armorValue: 3),
  thickSkin(name: "Thick skin", armorValue: 1);

  const ArmorType({
    required this.name,
    required this.armorValue,
  });

  final String name;
  final int armorValue;

  static ArmorType fromString(String weaponString) {
    return ArmorType.values
        .firstWhere((weapon) => weapon.toString() == weaponString);
  }
}
