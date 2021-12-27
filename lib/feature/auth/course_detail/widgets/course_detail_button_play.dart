import 'package:app_edu/common/model/lesson_model.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class CourseDetailButtonPlay extends StatelessWidget {
  final bool isPlaying;
  final bool showOutSide;
  final Function onButtonCenterTap;
  final Function onOutSideTap;
  final Function onFullScreen;
  final Function(int id)? onPreview;
  final Function(int id)? onNextVideo;
  final LessonModel? courseDetailModel;
  final int? time;
  final Function(int duration) onChangeTime;
  final VideoPlayerController? controller;
  final int currenTime;

  const CourseDetailButtonPlay({
    Key? key,
    this.isPlaying = false,
    required this.showOutSide,
    required this.onButtonCenterTap,
    required this.onOutSideTap,
    required this.onFullScreen,
    required this.onChangeTime,
    this.courseDetailModel,
    this.onPreview,
    required this.currenTime,
    this.time,
    this.controller,
    this.onNextVideo,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    String timeVideoText = _printDuration(Duration(seconds: time ?? 1));
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: InkWell(
        onTap: () {
          onOutSideTap();
        },
        child: Stack(
          children: [
            Container(
              color: showOutSide
                  ? Colors.black.withOpacity(0.3)
                  : Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              child: showOutSide
                  ? Center(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          courseDetailModel?.preId != null
                              ? CustomGestureDetector(
                            onTap: () {
                              if (onPreview != null) {
                                onPreview!(courseDetailModel?.preId ??
                                    0);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
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
                          InkWell(
                            onTap: () {
                              onButtonCenterTap();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          courseDetailModel?.nextId != null
                              ? CustomGestureDetector(
                            onTap: () {
                              if (onNextVideo != null) {
                                onNextVideo!(courseDetailModel
                                    ?.nextId ??
                                    0);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
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
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CustomGestureDetector(
                        onTap: onFullScreen,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.open_in_full,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      left: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              '${_printDuration(Duration(
                                seconds: currenTime.toInt(),
                              ))}/$timeVideoText',
                              style: AppTextTheme.normalWhite,
                            ),
                          ),
                          Slider(
                            onChanged: (double value) {
                              onChangeTime(value.toInt());
                            },
                            max: time?.toDouble() ?? 1,
                            thumbColor: Colors.red,
                            activeColor: Colors.red,
                            inactiveColor: Colors.white,
                            value:currenTime.toDouble(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

 