import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? right;
  final String? label;
  final bool? obscureText;
  final bool readOnly;
  final int? maxLine;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final Function? onTap;
  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.right,
    this.label,
    this.onTap,
    this.obscureText,
    this.maxLine,
    this.readOnly = false,
    this.textInputType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? hintText ?? '',
          style: AppTextTheme.normalBlack,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey5, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextFormField(
                controller: controller,
                obscureText: obscureText ?? false,
                readOnly: readOnly,
                maxLines: maxLine ?? 1,
                validator: validator,
                keyboardType: textInputType,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    contentPadding: EdgeInsets.only(bottom: 4, left: 16),
                    hintStyle: AppTextTheme.smallGrey.copyWith()),
              ),
            ),
            Positioned(
              child: right ?? const SizedBox(),
              right: 0,
            ),
            Visibility(
              visible: onTap != null,
              child: InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 56.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
