import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../injector_container.dart';
import 'custom_image_network.dart';

class BannerSlideImage extends StatefulWidget {
  final double? borderRadius;
  final double? height;
  final Widget? displayNumberImage;
  final bool autoPlay;
  final bool revert;
  final Duration? duration;
  final bool enableInfiniteScroll;
  final Function(int index)? onchangePage;
  final BoxFit? fit;

  const BannerSlideImage(
      {Key? key,
      this.borderRadius = 0,
      this.height,
      this.displayNumberImage,
      this.autoPlay = false,
      this.revert = false,
      this.duration,
      this.enableInfiniteScroll = false,
      this.onchangePage,
      this.fit})
      : super(key: key);

  @override
  _BannerSlideImageState createState() => _BannerSlideImageState();
}

class _BannerSlideImageState extends State<BannerSlideImage> {
  int _currentSlideIndex = 0;
  List<String> _images = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get('get-app-background');
      data['data'].forEach((e) {
        _images.add(e);
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: widget.height ?? 248.0,
          child: _images.isEmpty
              ? const Text(
                  'Không thể load banner!',
                  style: AppTextTheme.normalRobotoRed,
                )
              : CarouselSlider(
                  options: CarouselOptions(
                    initialPage: 0,
                    height: double.infinity,
                    autoPlay: true,
                    autoPlayAnimationDuration:
                        widget.duration ?? Duration(seconds: 3),
                    viewportFraction: 1.0,
                    reverse: widget.revert,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      if (widget.onchangePage != null) {
                        widget.onchangePage!(index);
                      }
                      setState(() {
                        _currentSlideIndex = index;
                      });
                    },
                  ),
                  items: _images
                      .map((e) => InkWell(
                            onTap: () {},
                            child: Container(
                              color: Colors.transparent,
                              child: CustomImageNetwork(
                                url: e,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                border: 12,
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ),
        const SizedBox(height: 12),
        _images.isEmpty
            ? const SizedBox()
            : Row(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(_images, (index, obj) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentSlideIndex == index
                              ? AppColors.primaryColor
                              : AppColors.grey4,
                        ),
                      );
                    }),
                  ),
                  Spacer(),
                ],
              )
      ],
    );
  }
}
