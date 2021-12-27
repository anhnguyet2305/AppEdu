import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/model/lesson_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/log_util.dart';
import 'package:app_edu/common/ultils/screen_utils.dart';
import 'package:app_edu/feature/auth/course_detail/widgets/course_detail_button_play.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:app_edu/feature/auth/widgets/custom_image_network.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';

import '../../injector_container.dart';

class LearningScreen extends StatefulWidget {
  final int? lessionId;

  const LearningScreen({Key? key, this.lessionId}) : super(key: key);

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  VideoPlayerController? _controller;
  LessonModel? _lessonModel;
  bool isPlayVideo = false;
  bool runFirstTime = true;
  bool showOutSide = true;
  bool _fullScreen = false;
  int _currentTime = 0;

  @override
  void initState() {
    _reGetData(widget.lessionId ?? 0);
    super.initState();
  }

  void _reGetData(int courseId) async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      AppCache appCache = injector<AppCache>();
      final data = await injector<AppClient>().get(
          'get-edu-lesson-info/$courseId?api_token=${appCache.profileModel?.apiToken}');
      _lessonModel = LessonModel.fromJson(data['data']);
      _controller = VideoPlayerController.network(_lessonModel?.clipLink ?? '')
        ..initialize().then((_) {
          setState(() {});
        });
      _controller?.addListener(() async {
        final data = await _controller?.position;
        if (_currentTime != data?.inSeconds) {
          LOG.d('addListener: ${data?.inSeconds}');
          _currentTime = data?.inSeconds ?? 0;
          setState(() {});
        }
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes CourseCubit');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  void dispose() {
    _controller?.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_fullScreen) {
          setState(() {
            _fullScreen = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Stack(
        children: [
          CustomScaffold(
            customAppBar: CustomAppBar(
              title: '${_lessonModel?.name ?? ''}',
              iconLeftTap: () {
                Routes.instance.pop();
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!isPlayVideo && runFirstTime)
                      ? Stack(
                          children: [
                            CustomImageNetwork(
                              url: _lessonModel?.clipCover,
                              height: 232,
                              width: double.infinity,
                            ),
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _lessonModel?.preId != null
                                          ? CustomGestureDetector(
                                              onTap: () {
                                                Routes.instance
                                                    .popAndNavigateTo(
                                                  routeName:
                                                      RouteName.learningScreen,
                                                  arguments:
                                                      _lessonModel?.preId,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.skip_previous,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 80,
                                              height: 80,
                                            ),
                                      const SizedBox(width: 16),
                                      CustomGestureDetector(
                                        onTap: () {
                                          setState(() {
                                            runFirstTime = false;
                                            isPlayVideo = true;
                                            _controller?.play();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      _lessonModel?.nextId != null
                                          ? CustomGestureDetector(
                                              onTap: () {
                                                Routes.instance
                                                    .popAndNavigateTo(
                                                  routeName:
                                                      RouteName.learningScreen,
                                                  arguments:
                                                      _lessonModel?.nextId,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.skip_next,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 80,
                                              height: 80,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 232,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_lessonModel?.name}',
                          style: AppTextTheme.mediumBlack.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        (_lessonModel?.content?.isNotEmpty ?? false)
                            ? Html(
                                data: _lessonModel?.content,
                                style: {
                                  "html": Style(
                                    backgroundColor: Colors.white,
                                    color: AppColors.grey9,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize(14),
                                    padding: EdgeInsets.all(0),
                                    fontStyle: FontStyle.normal,
                                    wordSpacing: 1.5,
                                  ),
                                },
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 8.0,
                        ),
                        InkWell(
                          onTap: () {
                            Routes.instance
                                .navigateTo(RouteName.documentScreen);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                IconConst.download,
                                width: 16,
                                height: 16,
                              ),
                              Text(
                                ' Tài liệu',
                                style: AppTextTheme.smallGrey,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          'File tham khảo',
                          style: AppTextTheme.normalYellow,
                        ),
                        const Divider(),
                        Text(
                          'Danh mục nội dung khoá học',
                          style: AppTextTheme.mediumBlack
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Column(
                          children: _lessonModel?.lessons
                                  ?.map((e) => _itemWidget(e))
                                  .toList() ??
                              [],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: _fullScreen ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(
                  left: _fullScreen ? GScreenUtil.statusBarHeight : 0,
                  top: _fullScreen
                      ? 0
                      : (GScreenUtil.statusBarHeight + defaultAppbar)),
              child: (!isPlayVideo && runFirstTime)
                  ? const SizedBox()
                  : (_controller != null
                      ? Stack(
                          children: [
                            Container(
                              child: VideoPlayer(_controller!),
                              width: double.infinity,
                              height: _fullScreen ? double.infinity : 232,
                              color: Colors.grey,
                            ),
                            Positioned.fill(
                              child: CourseDetailButtonPlay(
                                isPlaying: isPlayVideo,
                                showOutSide: showOutSide,
                                currenTime: _currentTime,
                                courseDetailModel: _lessonModel,
                                time: _lessonModel?.clipTime,
                                onNextVideo: (int id) {
                                  Routes.instance.popAndNavigateTo(
                                    routeName: RouteName.learningScreen,
                                    arguments: id,
                                  );
                                },
                                onChangeTime: (int value) {
                                  setState(() {
                                    _currentTime = value;
                                  });
                                  _controller?.seekTo(Duration(seconds: value));
                                },
                                onFullScreen: () {
                                  setState(() {
                                    _fullScreen = !_fullScreen;
                                  });
                                },
                                onOutSideTap: () {
                                  setState(() {
                                    showOutSide = !showOutSide;
                                  });
                                },
                                onPreview: (int id) {
                                  Routes.instance.popAndNavigateTo(
                                    routeName: RouteName.learningScreen,
                                    arguments: id,
                                  );
                                },
                                onButtonCenterTap: () {
                                  setState(() {
                                    isPlayVideo = !isPlayVideo;
                                  });
                                  if (isPlayVideo) {
                                    _controller?.play();
                                  } else {
                                    _controller?.pause();
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox()),
            ),
          )
        ],
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
        const SizedBox(
          height: 16,
        ),
        Column(
          children: lessons.lessonList?.map((e) => _lesson(e)).toList() ?? [],
        ),
      ],
    );
  }

  Widget _lesson(LessonList lessonList) {
    return CustomGestureDetector(
      onTap: () {
        Routes.instance.popAndNavigateTo(
            routeName: RouteName.learningScreen, arguments: lessonList.id);
      },
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                IconConst.video_cam,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${lessonList.name}',
                  style: AppTextTheme.normalBlack.copyWith(
                      color: widget.lessionId == lessonList.id
                          ? Colors.orange
                          : AppColors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          )
        ],
      ),
    );
  }
}
