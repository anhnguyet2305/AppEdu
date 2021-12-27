import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/auth/home/widgets/home_bottom_sheet.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeCenterWidget extends StatelessWidget {
  const HomeCenterWidget({Key? key}) : super(key: key);

  void _onSatHach(BuildContext context) {
    CommonUtil.showCustomBottomSheet(
        context: context,
        child: HomeBottomSheet(onTap: (int id) async {
          Routes.instance.pop();
          final data = await Routes.instance
              .navigateTo(RouteName.actionLessonScreen, arguments: id);
          if (data != null) {
            _onSatHach(context);
          }
        }),
        height: 180);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _item(IconConst.sathach, 'Sát Hạch CCHN', () {
          _onSatHach(context);
        }),
        _item(IconConst.hoat_tai, 'Hoạt Tải', () {
          Routes.instance.navigateTo(RouteName.hoatTaiScreen);
        }),
        _item(IconConst.vat_lieu, 'Vật Liệu', () {
          Routes.instance.navigateTo(RouteName.vatLieuScreen);
        }),
        _item(IconConst.so_tu_nhien, 'Số liệu Tự Nhiên', () {
          Routes.instance.navigateTo(RouteName.soLieuScreen);
        }),
        // _item(IconConst.tai_lieu, 'Tài liệu', () {
        //   Routes.instance.navigateTo(RouteName.DocumentScreen);
        // }),
      ],
    );
  }

  Widget _item(String icon, String text, Function onTap) {
    return Expanded(
        child: InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextTheme.normalBlack.copyWith(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
