enum Weapon implements Comparable<Weapon> {
  sword(name: "Sword", minDamage: 2, maxDamage: 5),
  axe(name: "Axe", minDamage: 3, maxDamage: 4),
  spear(name: "Spear", minDamage: 1, maxDamage: 6),
  fangs(name: "Fangs", minDamage: 1, maxDamage: 4),
  claws(name: "Claws", minDamage: 1, maxDamage: 3),
  bazooka(name: "Bazooka", minDamage: 10, maxDamage: 50);

  const Weapon({
    required this.name,
    required this.minDamage,
    required this.maxDamage,
  });

  final String name;
  final int minDamage;
  final int maxDamage;

  @override
  int compareTo(Weapon other) =>
      minDamage + maxDamage - other.minDamage - other.maxDamage;

  static Weapon fromString(String weaponString) {
    return Weapon.values
        .firstWhere((weapon) => weapon.toString() == weaponString);
  }
}
