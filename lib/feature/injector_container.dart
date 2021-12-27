import 'package:app_edu/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/local/local_app.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/feature/auth/course/cubit/course_cubit.dart';
import 'package:app_edu/feature/auth/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> init() async {
  _initCommon();
  _initBloc();
}

void _initBloc() {
  injector.registerLazySingleton(() => EventBusBloc());
  injector.registerLazySingleton(() => LoadingBloc());
  injector.registerLazySingleton(() => SnackBarBloc());
  injector.registerLazySingleton(() => AppCache());
  injector.registerFactory(() => HomeCubit(
        injector(),
        injector(),
      ));
  injector.registerFactory(() => CourseCubit(
        injector(),
        injector(),
        injector(),
      ));
}

void _initCommon() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(
      () => sharedPreferences); // lưu trữ thông tin, dữ liệu
  injector.registerLazySingleton(
    () => AppClient(
      injector(),
      injector(),
    ),
  );
  injector.registerLazySingleton(
    () => LocalApp(
      injector(),
    ),
  );
}
