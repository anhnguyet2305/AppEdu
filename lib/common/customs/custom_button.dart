import 'package:app_edu/common/const/string_const.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function onTap;
  final bool enable;

  const CustomButton({
    Key? key,
    this.text,
    this.enable = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: onTap,
      child: Container(
        width: 311,
        height: 44,
        decoration: BoxDecoration(
            color: enable ? Color(0xff3BB143) : AppColors.grey7,
            borderRadius: BorderRadius.circular(12),
            boxShadow: StringConst.defaultShadow),
        child: Center(
          child: Text(
            text ?? '',
            style: AppTextTheme.normalWhite.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
