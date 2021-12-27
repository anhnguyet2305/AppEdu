import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/forgot_password_with_email/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = '';
  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Column(
        children: [
          MyAppBar(title: 'Nhập mã OTP'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhập mã OTP',
                  style: AppTextTheme.title,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Mã OTP sẽ được gửi đến email của bạn',
                  style: AppTextTheme.normalGrey,
                ),
                SizedBox(
                  height: 32.0,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  cursorColor: AppColors.grey7,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    selectedColor: AppColors.grey7,
                    activeColor: AppColors.grey7,
                    errorBorderColor: Colors.red,
                    inactiveColor: AppColors.grey7,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  onChanged: (value) {
                    _otp = value;
                    setState(() {});
                  },
                  appContext: context,
                ),
                SizedBox(
                  height: 16.0,
                ),
                MyButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordScreen(),
                        ),
                      );
                    },
                    titleButton: 'Xác nhận')
              ],
            ),
          )
        ],
      ),
      bottomNav: SizedBox(),
    );
  }
}
