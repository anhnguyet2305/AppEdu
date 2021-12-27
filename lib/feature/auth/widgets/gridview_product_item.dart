import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/format_utils.dart';
import 'package:app_edu/feature/auth/widgets/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../routes.dart';

class CategoryDetailWidgetItemProduct extends StatelessWidget {
  final double itemWidth;
  final CourseModel? courseModel;

  const CategoryDetailWidgetItemProduct({
    Key? key,
    required this.itemWidth,
    this.courseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.instance
            .navigateTo(RouteName.courseDetailScreen, arguments: courseModel);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: courseModel?.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 97,
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseModel?.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextTheme.normalBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  Text(
                    courseModel?.mentor ?? '',
                    style: AppTextTheme.smallGrey,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(
                        IconConst.fakeStar,
                        width: 60,
                        height: 15,
                      ),
                      Text(
                        ' (${courseModel?.rated})',
                        style: AppTextTheme.smallBlack,
                      ),
                    ],
                  ),
                  (courseModel?.info?.runtimeType == String)
                      ? (courseModel?.info == 'Free'
                          ? const Text(
                              'FREE',
                              style: AppTextTheme.normalRobotoRed,
                            )
                          : Text(
                              'VIP',
                              style: AppTextTheme.normalYellow.copyWith(
                                  color: Colors.yellow[700],
                                  fontWeight: FontWeight.w800),
                            ))
                      : Text(
                          FormatUtils.formatCurrencyDoubleToString(
                              courseModel?.info),
                          style: AppTextTheme.smallBlack,
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
