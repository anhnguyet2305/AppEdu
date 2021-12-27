import 'dart:convert';

import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/const/key_save_data_local.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/local/local_app.dart';
import 'package:app_edu/common/model/profile_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/ultils/log_util.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    String? dataProfile = injector<LocalApp>()
        .getStringSharePreference(KeySaveDataLocal.keySaveDataProfile);
    LOG.d('_initData: $dataProfile');
    await Future.delayed(Duration(seconds: 1));
    if (dataProfile?.isNotEmpty ?? false) {
      injector<AppCache>().profileModel =
          ProfileModel.fromJson(json.decode(dataProfile!));
      Routes.instance.navigateTo(RouteName.containerScreen);
    } else {
      Routes.instance.navigateTo(RouteName.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconConst.logo,
              width: 207,
              height: 207,
            ),
          ],
        ),
      ),
    );
  }
}
