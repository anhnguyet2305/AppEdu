import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/auth/hoat_tai/hoat_tai_bottom_sheet.dart';
import 'package:app_edu/feature/auth/vat_lieu/vat_lieu_bottom_sheet.dart';
import 'package:app_edu/feature/auth/vat_lieu/vat_lieu_model.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class VatLieuScreen extends StatefulWidget {
  const VatLieuScreen({Key? key}) : super(key: key);

  @override
  _VatLieuScreenState createState() => _VatLieuScreenState();
}

class _VatLieuScreenState extends State<VatLieuScreen> {
  List<VatLieuModel> _hoatTais = [];
  VatLieuModel? _hoatTaiSelected;
  Data1? _hoatTaiChild;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get('get-tracuu-vatlieu');
      data['data'].forEach((e) {
        _hoatTais.add(VatLieuModel.fromJson(e));
      });
      _hoatTaiSelected = _hoatTais[0];
      _hoatTaiChild = _hoatTaiSelected?.data1?[0];
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  void _onSelectHoatTai1() {
    CommonUtil.showCustomBottomSheet(
        context: context,
        child: VatLieuBottomSheet(
          datas: _hoatTais.map((e) => e.address1 ?? '').toList(),
          onSelect: (String text) {
            _hoatTaiSelected =
                _hoatTais.firstWhere((element) => element.address1 == text);
            _hoatTaiChild = null;
          },
        ),
        height: 300);
  }

  void _onSelectHoatTai2() {
    CommonUtil.showCustomBottomSheet(
        context: context,
        child: HoatTaiBottomSheet(
          datas:
              _hoatTaiSelected?.data1?.map((e) => e.address2 ?? '').toList() ??
                  [],
          onSelect: (String text) {
            _hoatTaiChild = _hoatTaiSelected?.data1
                ?.firstWhere((element) => element.address2 == text);
            setState(() {});
          },
        ),
        height: 300);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Vật Liệu',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vật liệu'),
            const SizedBox(height: 8),
            _item('${_hoatTaiSelected?.address1 ?? ''}', () {
              _onSelectHoatTai1();
            }),
            const SizedBox(height: 16),
            const Text('Cấp bền'),
            const SizedBox(height: 8),
            _item(
                _hoatTaiChild != null
                    ? '${_hoatTaiChild?.address2 ?? ''}'
                    : 'Chọn', () {
              _onSelectHoatTai2();
            }),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey5,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Text(
                '${_hoatTaiChild?.data2?.toString() ?? ''}',
                style: AppTextTheme.mediumBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String text, Function onTap, {bool haveIcon = true}) {
    return CustomGestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey5)),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: AppTextTheme.mediumBlack,
              ),
            ),
            haveIcon ? Icon(Icons.keyboard_arrow_down) : const SizedBox(),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
