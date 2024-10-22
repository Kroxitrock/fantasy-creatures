import 'dart:convert';

import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/models/armor.dart';
import 'package:fantasy_creatures/models/creature.dart';
import 'package:fantasy_creatures/models/creature_size.dart';
import 'package:fantasy_creatures/models/weapon.dart';
import 'package:fantasy_creatures/widgets/navigation_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CreateOrUpdateCreaturePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final creatureController = Get.find<CreatureController>();

  final List<Weapon> confirmedWeapons = [];
  final List<ArmorType> confirmedArmor = [];

  CreateOrUpdateCreaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final creatureToUpdateUuid = Get.arguments;
    Creature? creatureToUpdate;

    if (creatureToUpdateUuid != null) {
      creatureToUpdate = creatureController.getCreature(creatureToUpdateUuid);
      confirmedArmor.addAll(creatureToUpdate!.armor);
      confirmedWeapons.addAll(creatureToUpdate.weapons);
    }

    return NavigationScaffoldWidget(
      FormBuilder(
        key: _formKey,
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: Center(
                      child: Text(creatureToUpdate != null
                          ? "Edit Creature"
                          : "Create a new Creature"),
                    ),
                    titleTextStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  FormBuilderTextField(
                    name: "name",
                    initialValue:
                        creatureToUpdate != null ? creatureToUpdate.name : '',
                    decoration: const InputDecoration(
                        label: Text("Name of the creature")),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderImagePicker(
                    initialValue: creatureToUpdate != null &&
                            creatureToUpdate.image != null
                        ? [MemoryImage(base64Decode(creatureToUpdate.image!))]
                        : [],
                    name: "image",
                    maxImages: 1,
                    availableImageSources: const [ImageSourceOption.gallery],
                  ),
                  FormBuilderTextField(
                    name: "description",
                    initialValue: creatureToUpdate != null
                        ? creatureToUpdate.description
                        : '',
                    decoration: const InputDecoration(
                      label: Text("Description of the creature"),
                    ),
                    maxLines: 3,
                    maxLength: 255,
                  ),
                  FormBuilderDropdown(
                    name: "size",
                    initialValue:
                        creatureToUpdate != null ? creatureToUpdate.size : '',
                    decoration: const InputDecoration(
                      label: Text("Size"),
                    ),
                    items: CreatureSize.values
                        .map(
                          (creatureSize) => DropdownMenuItem(
                            value: creatureSize,
                            child: Text(creatureSize.name),
                          ),
                        )
                        .toList(),
                    validator: FormBuilderValidators.required(),
                  ),
                  MultiSelectDialogField<Weapon>(
                    initialValue: creatureToUpdate != null
                        ? creatureToUpdate.weapons
                        : [],
                    dialogWidth: 150,
                    dialogHeight: height > 300 ? 300 : height,
                    title: const Text("Select weapons"),
                    buttonText: const Text(
                      "Weapons",
                      style: TextStyle(fontSize: 16),
                    ),
                    onConfirm: confirmWeapons,
                    chipDisplay: MultiSelectChipDisplay<Weapon>(
                      chipColor: Colors.amber,
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                    items: Weapon.values
                        .map((weapon) => MultiSelectItem(weapon, weapon.name))
                        .toList(),
                  ),
                  MultiSelectDialogField<ArmorType>(
                    initialValue:
                        creatureToUpdate != null ? creatureToUpdate.armor : [],
                    dialogWidth: 150,
                    dialogHeight: height > 300 ? 300 : height,
                    title: const Text("Select armor types"),
                    buttonText: const Text(
                      "Armor types",
                      style: TextStyle(fontSize: 16),
                    ),
                    onConfirm: confirmArmor,
                    chipDisplay: MultiSelectChipDisplay<ArmorType>(
                      chipColor: Colors.amber,
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                    items: ArmorType.values
                        .map((armorType) =>
                            MultiSelectItem(armorType, armorType.name))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () => creatureToUpdate != null
                          ? updateCreature(creatureToUpdateUuid)
                          : createCreature(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: Text(
                        creatureToUpdate != null ? "Edit" : "Create",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      2,
    );
  }

  confirmArmor(List<ArmorType> armor) {
    confirmedArmor.clear();
    confirmedArmor.addAll(armor);
  }

  confirmWeapons(List<Weapon> weapons) {
    confirmedWeapons.clear();
    confirmedWeapons.addAll(weapons);
  }

  updateCreature(String uuid) async {
    if (_formKey.currentState!.saveAndValidate()) {
      creatureController.updateCreature(Creature.withUuid(
          uuid,
          _formKey.currentState!.value['name'],
          await getImage(),
          _formKey.currentState!.value['description'],
          _formKey.currentState!.value['size'],
          confirmedWeapons,
          confirmedArmor));
      Get.back();
      Get.snackbar(
        "Creature Edited",
        "Successfully edited ${_formKey.currentState!.value['name']}!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createCreature() async {
    if (_formKey.currentState!.saveAndValidate()) {
      creatureController.addCreature(Creature(
          _formKey.currentState!.value['name'],
          await getImage(),
          _formKey.currentState!.value['description'],
          _formKey.currentState!.value['size'],
          confirmedWeapons,
          confirmedArmor));
      _formKey.currentState?.reset();

      Get.snackbar(
        "Creature created",
        "Successfully created ${_formKey.currentState!.value['name']}!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<String?> getImage() async {
    final image = _formKey.currentState!.value['image'];

    if (image == null) {
      return null;
    }

    if (image[0].runtimeType == XFile) {
      return base64Encode(await image[0].readAsBytes());
    }

    return base64Encode(image[0].bytes);
  }
}
