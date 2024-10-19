import 'package:fantasy_creatures/widgets/navigation_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationScaffoldWidget extends StatelessWidget {
  final Widget body;
  final int selectedIndex;

  const NavigationScaffoldWidget(this.body, this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: constructAppBar(width),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: body,
        ),
      ),
      bottomNavigationBar: constructNavBar(width),
    );
  }

  AppBar constructAppBar(double width) {
    var centerTitle = false;
    List<Widget> actions = [];

    if (width < 641) {
      centerTitle = true;
    } else {
      actions.addAll(
        [
          const NavigationButtonWidget("Home", "/"),
          const NavigationButtonWidget("Create Creature", "/create")
        ],
      );
    }

    final appBar = AppBar(
      backgroundColor: Colors.amber,
      title: const Text("Fantasy Creatures"),
      centerTitle: centerTitle,
      actions: actions,
    );

    return appBar;
  }

  Widget? constructNavBar(double width) {
    if (width > 641) {
      return null;
    }

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(
            Icons.home,
          ),
        ),
        BottomNavigationBarItem(
          label: "Create",
          icon: Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int value) {
    switch (value) {
      case 0:
        Get.toNamed("/");
        break;
      case 1:
        Get.toNamed("/create");
        break;
    }
  }
}
