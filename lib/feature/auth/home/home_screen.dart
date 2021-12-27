import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/feature/auth/all_course/all_course_screen.dart';
import 'package:app_edu/feature/auth/home/cubit/home_cubit.dart';
import 'package:app_edu/feature/auth/home/widgets/home_center.dart';
import 'package:app_edu/feature/auth/widgets/banner_slide_image.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/auth/widgets/gridview_product.dart';
import 'package:app_edu/feature/auth/widgets/shimmer/common_shimmer.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit _homeCubit = injector<HomeCubit>();

  @override
  void initState() {
    _homeCubit.getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BannerSlideImage(
                height: 200,
                fit: BoxFit.cover,
                borderRadius: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: HomeCenterWidget(),
            ),
            const Divider(),
            const SizedBox(height: 12),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: _homeCubit,
              builder: (_, state) {
                if (state is HomeGettingDataState) {
                  return CommonShimmer(
                    numberItem: 2,
                  );
                }
                if (state is HomeGotDataState &&
                    state.courseModels.isNotEmpty) {
                  return GridViewDisplayProduct(
                    label: 'Khoá học đang hot',
                    courses: state.courseModels,
                    onMore: () {
                      Routes.instance.navigateTo(RouteName.allCourseScreen,
                          arguments: ArgumentAllCourseScreen(
                              url: 'get-edu-courses-hot',
                              title: 'Khoá học đang hot',
                              haveIconHot: true));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: _homeCubit,
              builder: (_, state) {
                if (state is HomeGettingDataState) {
                  return CommonShimmer(
                    numberItem: 2,
                  );
                }
                if (state is HomeGotDataState && state.courseNew.isNotEmpty) {
                  return GridViewDisplayProduct(
                    label: 'Khoá học nổi bật',
                    courses: state.courseNew,
                    onMore: () {
                      Routes.instance.navigateTo(
                        RouteName.allCourseScreen,
                        arguments: ArgumentAllCourseScreen(
                          url: 'get-edu-courses-new',
                          title: 'Khoá học nổi bật',
                          haveIconHot: true,
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: _homeCubit,
              builder: (_, state) {
                if (state is HomeGettingDataState) {
                  return CommonShimmer(
                    numberItem: 2,
                  );
                }
                if (state is HomeGotDataState && state.myCourse.isNotEmpty) {
                  if (state.myCourse.isEmpty) {
                    return const SizedBox();
                  }
                  return GridViewDisplayProduct(
                    label: 'Khoá học đang học',
                    courses: state.myCourse,
                    onMore: () {
                      AppCache appCache = injector<AppCache>();
                      Routes.instance.navigateTo(RouteName.allCourseScreen,
                          arguments: ArgumentAllCourseScreen(
                            url:
                                'get-edu-courses-me?api_token=${appCache.profileModel?.apiToken}',
                            title: 'Khoá học đang học',
                            haveIconHot: true,
                          ));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
