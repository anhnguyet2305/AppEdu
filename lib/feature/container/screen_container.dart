import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/feature/auth/course/course_screen.dart';
import 'package:app_edu/feature/auth/home/home_screen.dart';
import 'package:app_edu/feature/auth/notification/notification_screen.dart';
import 'package:app_edu/feature/auth/setting/setting_screen.dart';
import 'package:app_edu/feature/auth/widgets/bottom_nagivation_widget.dart';
import 'package:app_edu/feature/auth/widgets/layout_contain_widget_keep_alive.dart';
import 'package:flutter/material.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNavigation(
        icons: [
          IconConst.sc_home,
          IconConst.sc_book,
          IconConst.sc_noti,
          IconConst.sc_setting,
        ],
        tabViews: [
          LayoutContainWidgetKeepAlive(child: HomeScreen()),
          LayoutContainWidgetKeepAlive(child: CourseScreen()),
          LayoutContainWidgetKeepAlive(child: NotificationScreen()),
          LayoutContainWidgetKeepAlive(child: SettingScreen()),
        ],
      ),
    );
  }
}
