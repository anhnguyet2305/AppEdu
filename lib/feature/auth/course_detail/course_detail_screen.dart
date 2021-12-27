import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/model/course_detail_model.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/model/lesson_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/auth/course_detail/widgets/course_detail_info.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:app_edu/feature/auth/widgets/custom_image_network.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class CourseDetailScreen extends StatefulWidget {
  final CourseModel? courseModel;

  const CourseDetailScreen({Key? key, this.courseModel}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  CourseDetailModel? _courseDetailModel;
  bool runFirstTime = true;
  bool showOutSide = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>()
          .get('get-edu-course-info/${widget.courseModel?.id}');
      _courseDetailModel = CourseDetailModel.fromJson(data['data']);
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes CourseCubit');
      Routes.instance.pop();
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldSafe(
      columnWidget: Column(
        children: [
          MyAppBar(title: '${_courseDetailModel?.name}'),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('${_courseDetailModel?.image}'),
                const SizedBox(
                  height: 16.0,
                ),
                CourseDetailInfo(
                  courseDetailModel: _courseDetailModel,
                  courseModel: widget.courseModel,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mô tả khoá học',
                        style: AppTextTheme.mediumBlack
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${_courseDetailModel?.content}',
                        style: AppTextTheme.normalBlack,
                      ),
                      Text(
                        'Danh mục nội dung khoá học',
                        style: AppTextTheme.mediumBlack
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: _courseDetailModel?.lessons
                                ?.map((e) => _itemWidget(e))
                                .toList() ??
                            [],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
      bottomNav: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.grey4),
          ),
        ),
        child: MyButton(
          onTap: () async {
            Routes.instance.navigateTo(
              RouteName.learningScreen,
              arguments: _courseDetailModel?.lessons?[0].lessonList?[0].id,
            );
          },
          titleButton: 'Tham gia khoá học',
        ),
      ),
    );
  }

  Widget _itemWidget(Lessons lessons) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${lessons.partName}',
                style: AppTextTheme.normalBlack.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // Image.asset(IconConst.up),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: lessons.lessonList?.map((e) => _lesson(e)).toList() ?? [],
        )
      ],
    );
  }

  Widget _lesson(LessonList lessonList) {
    return CustomGestureDetector(
      onTap: () {
        Routes.instance
            .navigateTo(RouteName.learningScreen, arguments: lessonList.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Image.asset(
              IconConst.video_cam,
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${lessonList.name}',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
