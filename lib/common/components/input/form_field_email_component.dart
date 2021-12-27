import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:flutter/material.dart';

class TextFieldEmail extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const TextFieldEmail(
      {Key? key, required this.labelText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.logoGreen,
      decoration: InputDecoration(
        fillColor: AppColors.grey7,
        labelText: labelText,
        labelStyle: AppTextTheme.normalGrey,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.logoGreen, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: ValidateUtil.validEmail,
      controller: controller,
    );
  }
}
