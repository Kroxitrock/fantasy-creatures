class Creature {
  String name;
  String? image;
  String? description;

  Creature(this.name, this.image, this.description);
  Creature.fromJson(Map jsonObject) : name = "" {
    name = jsonObject["name"];
    image = jsonObject["image"];
    description = jsonObject["description"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "description": description,
    };
  }
}
