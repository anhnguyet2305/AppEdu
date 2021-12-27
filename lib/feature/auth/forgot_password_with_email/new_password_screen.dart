
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Column(
        children: [
          MyAppBar(title: 'Quên mật khẩu'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              child: Column(
                key: _formKey,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      fillColor: AppColors.grey7,
                      labelText: 'Mật khẩu mới',
                      labelStyle: AppTextTheme.normalGrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    obscureText: _isObscure,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: ValidateUtil.validEmpty,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      fillColor: AppColors.grey7,
                      labelText: 'Nhập lại mật khẩu mới',
                      labelStyle: AppTextTheme.normalGrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    obscureText: _isObscure,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: ValidateUtil.validEmpty,
                    controller: _newPasswordController,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  MyButton(onTap: () {}, titleButton: 'Gửi'),
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
