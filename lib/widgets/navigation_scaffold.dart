import 'package:flutter/material.dart';

class NavigationScaffold extends StatelessWidget {
  final Widget body;

  const NavigationScaffold(this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: body,
        ),
      ),
    );
  }
}
