import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:app_edu/common/components/input/form_field_email_component.dart';
import 'package:app_edu/common/components/input/form_field_name_component.dart';
import 'package:app_edu/common/components/input/form_field_password_component.dart';
import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';

import '../../injector_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _repassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onRegister() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    if (_passController.text != _repassController.text) {
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        content: 'Nhập lại mật khẩu không khớp',
        type: SnackBarType.warning,
      ));
      return;
    }
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().post('signin', body: {
        'email': _emailController.text,
        'password': _passController.text,
        'password1': _repassController.text,
        'name': _nameController.text,
      });
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        content: data['msg'],
        type: SnackBarType.success,
        duration: Duration(seconds: 5),
      ));
      Routes.instance.pop();
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: '_onRegister');
      Routes.instance.pop();
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      bottomNav: SizedBox(),
      columnWidget: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(title: 'Đăng ký'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      IconConst.bg_register,
                      width: double.infinity,
                      height: 257,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    TextFieldEmail(
                        labelText: 'Email', controller: _emailController),
                    const SizedBox(height: 16),
                    TextFieldName(
                        labelText: 'Tên hiển thị', controller: _nameController),
                    const SizedBox(height: 16),
                    TextFieldPassword(
                        labelText: 'Mật khẩu',
                        obscureText: _obscureText1,
                        controller: _passController),
                    const SizedBox(height: 16),
                    TextFieldPassword(
                      labelText: 'Nhập lại mật khẩu',
                      obscureText: _obscureText2,
                      controller: _repassController,
                    ),
                    const SizedBox(height: 16),
                    MyButton(onTap: _onRegister, titleButton: 'Đăng kí'),
                    const SizedBox(height: 30),
                    CustomGestureDetector(
                      onTap: () {
                        Routes.instance.pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Bạn đã có tài khoản? ',
                                      style: AppTextTheme.normalGrey),
                                  TextSpan(
                                      text: 'Đăng nhập',
                                      style: AppTextTheme.normalLinkGreen)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
