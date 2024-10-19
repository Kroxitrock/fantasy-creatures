enum CreatureSize {
  small(name: "Small", minHealth: 5, maxHealth: 15),
  medium(name: "Medium", minHealth: 10, maxHealth: 20),
  big(name: "Big", minHealth: 15, maxHealth: 25);

  const CreatureSize({
    required this.name,
    required this.minHealth,
    required this.maxHealth,
  });

  final String name;
  final int minHealth;
  final int maxHealth;

  static CreatureSize fromString(String weaponString) {
    return CreatureSize.values
        .firstWhere((weapon) => weapon.toString() == weaponString);
  }
}
