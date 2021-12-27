import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onTap;
  final String titleButton;
  final bool enable;

  const MyButton(
      {Key? key,
      required this.onTap,
      required this.titleButton,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: enable ? AppColors.greenText : AppColors.grey7,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.7),
              blurRadius: 6,
              offset: Offset(4, 4), // Shadow position
            ),
          ],
        ),
        child: Text(
          titleButton,
          style: AppTextTheme.medium,
        ),
      ),
    );
  }
}
