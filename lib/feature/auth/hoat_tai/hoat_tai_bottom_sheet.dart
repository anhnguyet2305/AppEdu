import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/bottom_sheet_container.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class HoatTaiBottomSheet extends StatelessWidget {
  final Function(String text) onSelect;
  final List<String> datas;

  const HoatTaiBottomSheet({
    Key? key,
    required this.onSelect,
    required this.datas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      title: 'Chọn hoạt tải',
      onLeftTap: () {
        Routes.instance.pop();
      },
      child: SingleChildScrollView(
        child: Column(
          children: datas.map((e) => _item(e)).toList(),
        ),
      ),
    );
  }

  Widget _item(String text) {
    return CustomGestureDetector(
      onTap: () {
        Routes.instance.pop();
        onSelect(text);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: AppTextTheme.normalBlack,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
