import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/model/course_detail_model.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:flutter/material.dart';

class CourseDetailInfo extends StatelessWidget {
  final CourseDetailModel? courseDetailModel;
  final CourseModel? courseModel;

  const CourseDetailInfo({
    Key? key,
    this.courseDetailModel,
    this.courseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _item(IconConst.person, '${courseModel?.mentor}'),
            _item(IconConst.book,
                '${courseDetailModel?.lessons?.length ?? 0} bài giảng'),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _item(IconConst.mu, '${courseDetailModel?.rated ?? 0} học viên'),
            _item(IconConst.clock, '${courseDetailModel?.time} giờ học'),
          ],
        ),
        const SizedBox(height: 16),
        Divider(),
      ],
    );
  }

  Widget _item(String icon, String text) {
    return Expanded(
        child: Row(
      children: [
        const SizedBox(width: 16),
        Image.asset(
          icon,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 12),
        Text(text, style: AppTextTheme.smallBlack)
      ],
    ));
  }
}
