import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  String title;

  MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      title: Text(
        widget.title,
        style: AppTextTheme.mediumBlack,
      ),
      leading: IconButton(
        onPressed: () {
          Routes.instance.pop();
        },
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: AppColors.black,
        ),
      ),
    );
  }
}
