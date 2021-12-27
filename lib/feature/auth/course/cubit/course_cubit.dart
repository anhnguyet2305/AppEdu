import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/model/theme_model.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final LoadingBloc loadingBloc;

  CourseCubit(this.appClient, this.snackBarBloc, this.loadingBloc)
      : super(CourseInitState());

  void getThemes() async {
    try {
      loadingBloc.add(StartLoading());
      List<ThemeModel> result = [];
      final data = await appClient.get('get-edu-catalogs');
      data['data'].forEach((e) {
        result.add(ThemeModel.fromJson(e));
      });
      emit(CourseGotDataState(result));
    } catch (e) {
      emit(CourseGotDataState([]));
      CommonUtil.handleException(snackBarBloc, e,
          methodName: 'getThemes CourseCubit');
    } finally {
      loadingBloc.add(FinishLoading());
    }
  }
}

abstract class CourseState {}

class CourseInitState extends CourseState {}

class CourseGotDataState extends CourseState {
  final List<ThemeModel> themes;

  CourseGotDataState(this.themes);
}
