import 'package:flutter/material.dart';

class MyScaffoldSafe extends StatelessWidget {
  final Widget columnWidget;
  final Widget bottomNav;
  const MyScaffoldSafe(
      {Key? key, required this.columnWidget, required this.bottomNav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: bottomNav,
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: columnWidget),
      ),
    );
  }
}
