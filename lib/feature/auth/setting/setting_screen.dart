import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/const/key_save_data_local.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/custom_button.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/local/local_app.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Cài đặt',
              style: AppTextTheme.mediumBlack,
            ),
          ),
          GestureDetector(
            onTap: () {
              Routes.instance.navigateTo(RouteName.infoScreen);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.grey4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thông tin cá nhân',
                    style: AppTextTheme.normalRoboto,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final profileModel = injector<AppCache>().profileModel;
              Routes.instance.navigateTo(RouteName.changePasswordScreen,
                  arguments: profileModel?.email);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.grey4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đổi mật khẩu',
                    style: AppTextTheme.normalRoboto,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Routes.instance.navigateTo(RouteName.WebViewScreen,
                  arguments: 'https://ketcausoft.com/#');
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.grey4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chính sách và điều khoản',
                    style: AppTextTheme.normalRoboto,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyButton(
              onTap: () async {
                try {
                  injector<LoadingBloc>().add(StartLoading());
                  AppCache appCache = injector<AppCache>();
                  await injector<AppClient>().post('logout',
                      body: {'email': '${appCache.profileModel?.email}'});
                  injector<LocalApp>().saveStringSharePreference(
                      KeySaveDataLocal.keySaveDataProfile, '');
                  Routes.instance.navigateAndRemove(RouteName.loginScreen);
                } catch (e) {
                  CommonUtil.handleException(injector<SnackBarBloc>(), e,
                      methodName: 'onLogOut');
                  Routes.instance.pop();
                } finally {
                  injector<LoadingBloc>().add(FinishLoading());
                }
              },
              titleButton: 'Đăng xuất',
            ),
          ), // ở đây
        ],
      ),
      bottomNav: SizedBox(),
    );
  }
}
