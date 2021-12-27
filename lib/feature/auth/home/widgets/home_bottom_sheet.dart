import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/bottom_sheet_container.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';

class HomeBottomSheet extends StatefulWidget {
  final Function(int id) onTap;

  const HomeBottomSheet({Key? key, required this.onTap}) : super(key: key);

  @override
  _HomeBottomSheetState createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      onLeftTap: () {
        Routes.instance.pop();
      },
      title: 'Chọn',
      child: Column(
        children: [
          _item('Bài thi đầy đủ', 1),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.grey4,
          ),
          _item('Bài thi luật', 0),
        ],
      ),
    );
  }

  Widget _item(String text, int id) {
    return CustomGestureDetector(
      onTap: () {
        widget.onTap(id);
      },
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Text(
              text,
              style: AppTextTheme.normalGrey9,
            ),
          ],
        ),
      ),
    );
  }
}
