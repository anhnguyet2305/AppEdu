import 'package:app_edu/common/components/input/form_field_email_component.dart';
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/auth/otp/otp_screen.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Column(
        children: [
          MyAppBar(title: 'Quên mật khẩu'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldEmail(
                      labelText: 'Email', controller: _emailController),
                  SizedBox(
                    height: 16.0,
                  ),
                  MyButton(
                      onTap: () {
                        if (!CommonUtil.validateAndSave(_formKey)) return;
                        Routes.instance.navigateTo(
                            RouteName.changePasswordScreen,
                            arguments: _emailController.text);
                      },
                      titleButton: 'Gửi'),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNav: SizedBox(),
    );
  }
}
