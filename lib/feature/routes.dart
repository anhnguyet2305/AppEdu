import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/ultils/log_util.dart';
import 'package:app_edu/feature/auth/action_lesson/action_lesson_screen.dart';
import 'package:app_edu/feature/auth/all_course/all_course_screen.dart';
import 'package:app_edu/feature/auth/change_password/change_password_screen.dart';
import 'package:app_edu/feature/auth/course_detail/course_detail_screen.dart';
import 'package:app_edu/feature/auth/document/document_screen.dart';
import 'package:app_edu/feature/auth/forgot_password_with_email/forgot_password_screen.dart';
import 'package:app_edu/feature/auth/hoat_tai/hoat_tai_screen.dart';
import 'package:app_edu/feature/auth/learning/learning_screen.dart';
import 'package:app_edu/feature/auth/login_with_gmail_and_pass/login_screen.dart';
import 'package:app_edu/feature/auth/register_with_gmail/register_screen.dart';
import 'package:app_edu/feature/auth/result/result_screen.dart';
import 'package:app_edu/feature/auth/setting/personal_information_screen.dart';
import 'package:app_edu/feature/auth/so_lieu/so_lieu_screen.dart';
import 'package:app_edu/feature/auth/splash/splash_screen.dart';
import 'package:app_edu/feature/auth/vat_lieu/vat_lieu_screen.dart';
import 'package:app_edu/feature/container/screen_container.dart';
import 'package:app_edu/feature/webview/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'injector_container.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndNavigateTo(
      {dynamic result, String? routeName, dynamic arguments}) {
    return navigatorKey.currentState!
        .popAndPushNamed(routeName ?? '', arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  dynamic popUntil() {
    return navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    injector<LoadingBloc>().add(FinishLoading());
    return navigatorKey.currentState!.pop(result);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    LOG.d('LOG ROUTE_NAVIGATOR: ${settings.name}');
    switch (settings.name) {
      case RouteName.WebViewScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              WebViewScreen(url: settings.arguments as String),
        );
      case RouteName.loginScreen:
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RouteName.containerScreen:
        return CupertinoPageRoute(
          builder: (context) => ContainerScreen(),
        );
      case RouteName.forgotPassScreen:
        return CupertinoPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        );
      case RouteName.registerScreen:
        return CupertinoPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case RouteName.splashScreen:
        return CupertinoPageRoute(
          builder: (context) => SplashScreen(),
        );
      case RouteName.infoScreen:
        return CupertinoPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case RouteName.changePasswordScreen:
        return CupertinoPageRoute(
          builder: (context) => ChangePasswordScreen(
            email: settings.arguments != null
                ? settings.arguments as String
                : null,
          ),
        );
      case RouteName.resultScreen:
        return CupertinoPageRoute(
          builder: (context) => ResultScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentResultScreen
                : null,
          ),
        );
      case RouteName.actionLessonScreen:
        return CupertinoPageRoute(
          builder: (context) => ActionLessonScreen(
            id: settings.arguments != null ? settings.arguments as int : null,
          ),
        );
      case RouteName.hoatTaiScreen:
        return CupertinoPageRoute(
          builder: (context) => HoatTaiScreen(),
        );
      case RouteName.soLieuScreen:
        return CupertinoPageRoute(
          builder: (context) => SoLieuScreen(),
        );
      case RouteName.vatLieuScreen:
        return CupertinoPageRoute(
          builder: (context) => VatLieuScreen(),
        );
      case RouteName.courseDetailScreen:
        return CupertinoPageRoute(
          builder: (context) => CourseDetailScreen(
            courseModel: settings.arguments != null
                ? settings.arguments as CourseModel
                : null,
          ),
        );
      case RouteName.allCourseScreen:
        return CupertinoPageRoute(
          builder: (context) => AllCourseScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentAllCourseScreen
                : null,
          ),
        );
      case RouteName.learningScreen:
        return CupertinoPageRoute(
          builder: (context) => LearningScreen(
            lessionId:
                settings.arguments != null ? settings.arguments as int : null,
          ),
        );
      case RouteName.documentScreen:
        return CupertinoPageRoute(
          builder: (context) => DocumentScreen(),
        );
      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
