import 'dart:math';

import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/screen_utils.dart';
import 'package:app_edu/feature/auth/widgets/gridview_product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewDisplayProduct extends StatelessWidget {
  final int numberItem;
  final String label;
  final bool haveIcon;
  final List<CourseModel>? courses;
  final bool notExpand;
  final Function? onMore;

  const GridViewDisplayProduct({
    Key? key,
    this.numberItem = 2,
    required this.label,
    this.courses,
    this.notExpand = false,
    this.haveIcon = true,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (courses?.isEmpty ?? true) {
      return SizedBox();
    }
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 40;
    final numberRow = CommonUtil.countNumberRowOfGridview(courses);
    final heightList =
        (notExpand ? min(numberRow, 2) : numberRow) * (_itemHeight + 25);
    return Column(
      children: [
        Row(
          children: [
            haveIcon
                ? Row(
                    children: [
                      const SizedBox(width: 12),
                      Image.asset(
                        IconConst.hot,
                        width: 19,
                        height: 27,
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextTheme.mediumBlack.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (onMore != null) {
                  onMore!();
                }
                ;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Xem thêm',
                  style: AppTextTheme.normalGrey,
                ),
              ),
            )
          ],
        ),
        Container(
          width: double.infinity,
          height: heightList,
          child: GridView.builder(
            itemCount:
                notExpand ? min(courses?.length ?? 0, 4) : courses?.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: _itemWidth / _itemHeight,
            ),
            itemBuilder: (context, index) {
              return CategoryDetailWidgetItemProduct(
                itemWidth: _itemWidth,
                courseModel: courses?[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
