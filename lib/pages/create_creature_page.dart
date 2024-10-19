import 'dart:convert';

import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/models/creature.dart';
import 'package:fantasy_creatures/widgets/navigation_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class CreateCreaturePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final creatureController = Get.find<CreatureController>();

  CreateCreaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
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
                ElevatedButton(
                  onPressed: createCreature,
                  child: const Text("Create"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createCreature() async {
    if (_formKey.currentState!.saveAndValidate()) {
      creatureController.addCreature(Creature(
          _formKey.currentState!.value['name'],
          await getImage(),
          _formKey.currentState!.value['description']));
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
