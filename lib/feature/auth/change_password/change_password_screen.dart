import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:app_edu/common/components/input/form_field_password_component.dart';
import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/custom_textfield.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String? email;
  const ChangePasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  TextEditingController _passController = TextEditingController();
  TextEditingController _repassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSave() async {
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
      final data = await injector<AppClient>().post('reset-password', body: {
        'password': _passController.text,
        'password1': _repassController.text,
        'email': widget.email,
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
      columnWidget: Column(
        children: [
          MyAppBar(title: 'Đổi mật khẩu'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFieldPassword(
                    labelText: 'Mật khẩu mới',
                    obscureText: _obscureText1,
                    controller: _passController,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFieldPassword(
                    labelText: 'Nhập lại mật khẩu mới',
                    obscureText: _obscureText2,
                    controller: _repassController,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  MyButton(onTap: _onSave, titleButton: 'Lưu')
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNav: SizedBox(),
    );
  }
}
