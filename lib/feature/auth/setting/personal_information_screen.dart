import 'dart:io';

import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:app_edu/common/components/input/form_field_email_component.dart';
import 'package:app_edu/common/components/input/form_field_name_component.dart';
import 'package:app_edu/common/const/key_save_data_local.dart';
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/local/local_app.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/validate_ultil.dart';
import 'package:app_edu/feature/auth/widgets/bottom_sheet_date_picker.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  File? avt;
  String _dateTime = '';
  Future pickImageAvt() async {
    try {
      final avt = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (avt == null) return;

      final imageTemporaryAvt = File(avt.path);
      this.avt = imageTemporaryAvt;

      setState(() => this.avt = imageTemporaryAvt);
    } on PlatformException catch (e) {
      print('Failed to pick images : $e');
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();

  void _onDone() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final password1 = injector<LocalApp>()
          .getStringSharePreference(KeySaveDataLocal.keySavePassword);
      final profileModel = injector<AppCache>().profileModel;
      await injector<AppClient>().post('update-info', body: {
        'email': profileModel?.email,
        'api_token': profileModel?.apiToken,
        'password1': password1,
        'name': _nameController.text,
        // 'birthday': _dateTime,
        // 'sdt': _phoneController.text,
      });
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
          type: SnackBarType.success,
          content: 'Cập nhật thông tin thành công!.\nVui lòng nhập lại'));
      await Future.delayed(Duration(seconds: 1));
      AppCache appCache = injector<AppCache>();
      await injector<AppClient>()
          .post('logout', body: {'email': '${appCache.profileModel?.email}'});
      injector<LocalApp>()
          .saveStringSharePreference(KeySaveDataLocal.keySaveDataProfile, '');
      Routes.instance.navigateAndRemove(RouteName.loginScreen);
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  String convertDateTimeToDisplay(DateTime? input) {
    if (input == null) {
      return '';
    }
    DateFormat dateFormatInput = DateFormat('dd/MM/yyyy');
    return dateFormatInput.format(input);
  }

  void _selectDateTimeBirthDay(context) {
    CommonUtil.showCustomBottomSheet(
      context: context,
      child: BottomSheetDatePicker(
        onDateTimeChanged: (DateTime? date) {
          if (date != null) {
            DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
            _dateTime = dateFormat.format(date);
            _birthdayController.text = convertDateTimeToDisplay(date);
          }
        },
      ),
      height: 400,
    );
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    final profileModel = injector<AppCache>().profileModel;
    _nameController.text = profileModel?.name ?? '';
    _emailController.text = profileModel?.email ?? '';

    _phoneController.text = profileModel?.sdt ?? '';
    _birthdayController.text = profileModel?.birthday ?? '';
    _dateTime =
        CommonUtil.convertDateDataToDateDisplay(_birthdayController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Column(
        children: [
          MyAppBar(title: 'Thông tin cá nhân'),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: pickImageAvt,
                            child: Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 1.0),
                                color: Color(0xffE5E5E5),
                              ),
                              child: avt != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      child:
                                          Image.file(avt!, fit: BoxFit.cover))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      child: Image.asset(
                                        "assets/images/avt.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: GestureDetector(
                          onTap: pickImageAvt,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: AppColors.grey4,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFieldName(
                      labelText: 'Tên hiển thị', controller: _nameController),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFieldEmail(
                      labelText: 'Email', controller: _emailController),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    cursorColor: AppColors.logoGreen,
                    decoration: const InputDecoration(
                      fillColor: AppColors.grey7,
                      labelText: 'Số điện thoại',
                      labelStyle: AppTextTheme.normalGrey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.logoGreen, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.newline,
                    validator: ValidateUtil.validPhone,
                    controller: _phoneController,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    cursorColor: AppColors.logoGreen,
                    decoration: const InputDecoration(
                      fillColor: AppColors.grey7,
                      labelText: 'Ngày sinh',
                      labelStyle: AppTextTheme.normalGrey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.logoGreen, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: ValidateUtil.validEmpty,
                    controller: _birthdayController,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  MyButton(onTap: _onDone, titleButton: 'Lưu lại'),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNav: const SizedBox(),
    );
  }
}
