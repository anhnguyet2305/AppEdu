import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../routes.dart';
import 'custom_gesturedetactor.dart';

const double defaultAppbar = 56.0;

class CustomScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? customAppBar;
  final Widget? body;
  final Widget? appbarWidget;
  final bool autoDismissKeyboard;
  final bool? resizeToAvoidBottomInset;
  final bool paddingBottom;

  const CustomScaffold({
    Key? key,
    this.backgroundColor,
    this.customAppBar,
    this.body,
    this.appbarWidget,
    this.autoDismissKeyboard = false,
    this.paddingBottom = true,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      body: Column(
        children: [
          customAppBar ??
              (appbarWidget ?? SizedBox(height: GScreenUtil.statusBarHeight)),
          const Divider(height: 1, color: AppColors.grey5),
          Expanded(
            child: CustomGestureDetector(
                onTap: autoDismissKeyboard
                    ? () {
                        CommonUtil.dismissKeyBoard(context);
                      }
                    : () {},
                child: body ?? const SizedBox()),
          ),
          SizedBox(height: paddingBottom ? GScreenUtil.bottomBarHeight : 0),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? iconLeft;
  final Function? iconLeftTap;
  final bool stylePrimary;
  final bool hasShadow;
  final Widget? widgetRight;
  final Widget? icon;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.iconLeft,
    this.icon,
    this.iconLeftTap,
    this.stylePrimary = false,
    this.hasShadow = true,
    this.widgetRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: (GScreenUtil.statusBarHeight)),
      height: defaultAppbar + (GScreenUtil.statusBarHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomGestureDetector(
            onTap: () {
              if (iconLeftTap != null) {
                iconLeftTap!();
              } else {
                Routes.instance.pop();
              }
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 20, top: 16, bottom: 16),
              child: Center(
                  child: Image.asset(
                IconConst.back,
                width: 10,
                height: 20,
                fit: BoxFit.cover,
              )),
            ),
          ),
          icon ?? const SizedBox(),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: AppTextTheme.mediumBlack,
            ),
          ),
          widgetRight ??
              SizedBox(
                width: 60,
              )
        ],
      ),
    );
  }
}
