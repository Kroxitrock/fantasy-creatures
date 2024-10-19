import 'package:fantasy_creatures/controllers/creature_controller.dart';
import 'package:fantasy_creatures/pages/create_creature_page.dart';
import 'package:fantasy_creatures/pages/home_page.dart';
import 'package:fantasy_creatures/services/creature_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.lazyPut<CreatureService>(() => CreatureService());
  Get.lazyPut<CreatureController>(() => CreatureController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/create', page: () => CreateCreaturePage())
      ],
    );
  }
}
