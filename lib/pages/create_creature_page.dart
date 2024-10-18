import 'dart:convert';

import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/models/creature.dart';
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
    return Scaffold(
        body: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  name: "name",
                  decoration: const InputDecoration(
                      label: Text("Name of the creature")),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderImagePicker(
                  name: "image",
                  maxImages: 1,
                ),
                FormBuilderTextField(
                  name: "description",
                  decoration: const InputDecoration(
                      label: Text("Description of the creature")),
                ),
                ElevatedButton(
                    onPressed: createCreature, child: const Text("Create"))
              ],
            )));
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
