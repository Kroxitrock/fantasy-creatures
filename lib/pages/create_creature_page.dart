import 'dart:convert';

import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/models/creature.dart';
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

class CreateCreaturePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final creatureController = Get.find<CreatureController>();

  final List<Weapon> confirmedWeapons = [];

  CreateCreaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return NavigationScaffoldWidget(
      FormBuilder(
        key: _formKey,
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const ListTile(
                  title: Center(
                    child: Text("Create a new Creature"),
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                FormBuilderTextField(
                  name: "name",
                  decoration: const InputDecoration(
                      label: Text("Name of the creature")),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderImagePicker(
                  name: "image",
                  maxImages: 1,
                  availableImageSources: const [ImageSourceOption.gallery],
                ),
                FormBuilderTextField(
                  name: "description",
                  decoration: const InputDecoration(
                    label: Text("Description of the creature"),
                  ),
                  maxLines: 3,
                  maxLength: 255,
                ),
                MultiSelectDialogField(
                  dialogWidth: 150,
                  dialogHeight: height > 300 ? 300 : height,
                  title: const Text("Select weapons"),
                  buttonText: const Text(
                    "Weapons of the creature",
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
                ElevatedButton(
                  onPressed: createCreature,
                  child: const Text("Create"),
                )
              ],
            ),
          ),
        ),
      ),
      1,
    );
  }

  confirmWeapons(List<Weapon> weapons) {
    confirmedWeapons.clear();
    confirmedWeapons.addAll(weapons);
  }

  void createCreature() async {
    if (_formKey.currentState!.saveAndValidate()) {
      creatureController.addCreature(Creature(
          _formKey.currentState!.value['name'],
          await getImage(),
          _formKey.currentState!.value['description'],
          confirmedWeapons));
      _formKey.currentState?.reset();
    }
  }

  Future<String?> getImage() async {
    final image = _formKey.currentState!.value['image'];

    if (image == null) {
      return null;
    }

    XFile file = image[0];

    return base64Encode(await file.readAsBytes());
  }
}
