import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationButtonWidget extends StatelessWidget {
  final String text;
  final String navigateTo;

  const NavigationButtonWidget(this.text, this.navigateTo, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.toNamed(navigateTo),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
