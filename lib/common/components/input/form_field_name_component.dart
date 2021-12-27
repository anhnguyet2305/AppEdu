import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const TextFieldName(
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.logoGreen, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: ValidateUtil.validName,
      controller: controller,
    );
  }
}
