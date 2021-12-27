import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/model/theme_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/feature/auth/all_course/all_course_screen.dart';
import 'package:app_edu/feature/auth/course/widgets/course_theme.dart';
import 'package:app_edu/feature/auth/home/cubit/home_cubit.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/auth/widgets/gridview_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injector_container.dart';
import '../../routes.dart';
import 'cubit/course_cubit.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final CourseCubit _courseCubit = injector<CourseCubit>();
  List<ThemeModel>? _themes;
  List<CourseModel>? _courses1;
  List<CourseModel>? _courses2;
  List<CourseModel>? _courses3;

  @override
  void initState() {
    _courseCubit.getThemes();
    super.initState();
  }

  void _onThemeTap(ThemeModel themeModel) {
    Routes.instance.navigateTo(RouteName.allCourseScreen,
        arguments: ArgumentAllCourseScreen(
          url: 'get-edu-catalog-courses/${themeModel.id}',
          title: themeModel.name,
        ));
  }

  void _getDataCourseBottom(List<ThemeModel> themes) async {
    _themes = themes;
    _courses1 = await injector<HomeCubit>()
        .getCourse('get-edu-catalog-courses/${themes[0].id}');
    _courses2 = await injector<HomeCubit>()
        .getCourse('get-edu-catalog-courses/${themes[01].id}');
    _courses3 = await injector<HomeCubit>()
        .getCourse('get-edu-catalog-courses/${themes[2].id}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<CourseCubit, CourseState>(
                bloc: _courseCubit,
                listener: (_, state) {
                  if (state is CourseGotDataState) {
                    _getDataCourseBottom(state.themes);
                  }
                },
                builder: (_, state) {
                  if (state is CourseGotDataState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CourseTheme(
                        onTap: _onThemeTap,
                        themes: state.themes,
                      ),
                    );
                  }
                  return const SizedBox();
                }),
            const SizedBox(height: 20),
            GridViewDisplayProduct(
              numberItem: 2,
              courses: _courses1,
              label: '${_themes?[0].name}',
              haveIcon: false,
              notExpand: true,
              onMore: () {
                Routes.instance.navigateTo(RouteName.allCourseScreen,
                    arguments: ArgumentAllCourseScreen(
                      url: 'get-edu-catalog-courses/${_themes?[0].id}',
                      title: _themes?[0].name,
                    ));
              },
            ),
            const SizedBox(height: 16),
            GridViewDisplayProduct(
              numberItem: 2,
              courses: _courses2,
              label: '${_themes?[1].name}',
              onMore: () {
                Routes.instance.navigateTo(RouteName.allCourseScreen,
                    arguments: ArgumentAllCourseScreen(
                      url: 'get-edu-catalog-courses/${_themes?[1].id}',
                      title: _themes?[1].name,
                    ));
              },
              notExpand: true,
              haveIcon: false,
            ),
            const SizedBox(height: 16),
            GridViewDisplayProduct(
              numberItem: 2,
              courses: _courses3,
              label: '${_themes?[2].name}',
              haveIcon: false,
              notExpand: true,
              onMore: () {
                Routes.instance.navigateTo(
                  RouteName.allCourseScreen,
                  arguments: ArgumentAllCourseScreen(
                    url: 'get-edu-catalog-courses/${_themes?[2].id}',
                    title: _themes?[2].name,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
