import 'dart:convert';

import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/components/input/form_field_email_component.dart';
import 'package:app_edu/common/components/input/form_field_password_component.dart';
import 'package:app_edu/common/const/key_save_data_local.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/custom_button.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/local/local_app.dart';
import 'package:app_edu/common/model/profile_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:app_edu/feature/auth/forgot_password_with_email/forgot_password_screen.dart';
import 'package:app_edu/feature/auth/register_with_gmail/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../injector_container.dart';
import '../../routes.dart';

// 'email': 'hunghovan288@gmail.com',
// 'password': _passwordController.text,

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLogin() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().post('login', body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      });
      injector<LocalApp>().saveStringSharePreference(
          KeySaveDataLocal.keySavePassword, _passwordController.text);
      ProfileModel profileModel = ProfileModel.fromJson(data['data']);
      injector<LocalApp>().saveStringSharePreference(
          KeySaveDataLocal.keySaveDataProfile,
          json.encode(profileModel.toJson()));
      injector<AppCache>().profileModel = profileModel;
      Routes.instance.navigateAndRemove(RouteName.containerScreen);
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: '_onLogin');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/login/group_207.png',
                width: double.infinity,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Xin chào!',
                style: AppTextTheme.title,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'Vui lòng đăng nhập để tiếp tục',
                style: AppTextTheme.normalGrey,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFieldEmail(labelText: 'Email', controller: _emailController),
              const SizedBox(
                height: 16.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFieldPassword(
                  labelText: 'Mật khẩu',
                  obscureText: _isObscure,
                  controller: _passwordController),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes.instance.navigateTo(RouteName.forgotPassScreen);
                    },
                    child: Text(
                      'Quên mật khẩu?',
                      style: AppTextTheme.normalGrey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              MyButton(onTap: _onLogin, titleButton: 'Đăng nhập'),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa có tài khoản? ',
                    style: AppTextTheme.normalRoboto,
                  ),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.navigateTo(RouteName.registerScreen);
                    },
                    child: Text(
                      ' Đăng ký ',
                      style: AppTextTheme.normalLinkGreen,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNav: SizedBox(),
    );
  }
}
