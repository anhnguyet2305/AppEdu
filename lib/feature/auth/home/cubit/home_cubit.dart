import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injector_container.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;

  HomeCubit(this.appClient, this.snackBarBloc) : super(HomeInitState());

  void getInitData() async {
    try {
      emit(HomeGettingDataState());
      AppCache appCache = injector<AppCache>();
      final courseHot = await getCourse('get-edu-courses-hot');
      final courseNew = await getCourse('get-edu-courses-new');
      final myCourse = await getCourse(
          'get-edu-courses-me?api_token=${appCache.profileModel?.apiToken}');
      emit(HomeGotDataState(
        courseHot,
        courseNew,
        myCourse,
      ));
    } catch (e) {
      emit(HomeGotDataState([], [], []));
      CommonUtil.handleException(snackBarBloc, e,
          methodName: 'getInitData HomeCubit');
    }
  }

  Future<List<CourseModel>> getCourse(String endPoint) async {
    List<CourseModel> result = [];
    final data = await appClient.get(endPoint);
    data['data'].forEach((e) {
      result.add(CourseModel.fromJson(e));
    });
    return result;
  }
}

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeGettingDataState extends HomeState {}

class HomeGotDataState extends HomeState {
  final List<CourseModel> courseModels;
  final List<CourseModel> courseNew;
  final List<CourseModel> myCourse;

  HomeGotDataState(
    this.courseModels,
    this.courseNew,
    this.myCourse,
  );
}
