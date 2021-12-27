import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget? child;
  final String? title;
  final Function onLeftTap;
  final Function? onRightTap;
  final String? textButtonRight;

  const BottomSheetContainer({
    Key? key,
    this.child,
    this.title,
    required this.onLeftTap,
    this.onRightTap,
    this.textButtonRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          CustomGestureDetector(
            onTap: () {
              onLeftTap();
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.close,
                      color: AppColors.grey9,
                      size: 20,
                    )),
                  ),
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: AppTextTheme.mediumBlack,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onRightTap!();
                    },
                    child: Container(
                      width: 56,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        textButtonRight ?? '',
                        style: AppTextTheme.normalBlue,
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(height: 1, color: AppColors.grey5),
          Expanded(child: child ?? SizedBox()),
        ],
      ),
    );
  }
}
