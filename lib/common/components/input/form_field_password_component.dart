import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  final String labelText;
  bool obscureText;
  final TextEditingController? controller;

  TextFieldPassword(
      {Key? key,
      required this.labelText,
      required this.obscureText,
      required this.controller})
      : super(key: key);

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.logoGreen,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            color: AppColors.grey7,
            icon: Icon(
                widget.obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            }),
        fillColor: AppColors.grey7,
        labelText: widget.labelText,
        labelStyle: AppTextTheme.normalGrey,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.logoGreen, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      obscureText: widget.obscureText,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      validator: ValidateUtil.validEmpty,
      controller: widget.controller,
    );
  }
}
