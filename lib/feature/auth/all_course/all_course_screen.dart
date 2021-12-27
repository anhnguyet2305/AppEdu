import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/model/course_model.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/ultils/screen_utils.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/auth/widgets/gridview_product_item.dart';
import 'package:flutter/material.dart';

import '../../injector_container.dart';
import '../../routes.dart';

class ArgumentAllCourseScreen {
  final String? url;
  final String? title;
  final bool? haveIconHot;

  ArgumentAllCourseScreen({this.url, this.title, this.haveIconHot});
}

class AllCourseScreen extends StatefulWidget {
  final ArgumentAllCourseScreen? argument;

  const AllCourseScreen({Key? key, this.argument}) : super(key: key);

  @override
  _AllCourseScreenState createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  List<CourseModel> _allCourseModel = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get(widget.argument?.url ?? '');
      data['data'].forEach((e) {
        _allCourseModel.add(CourseModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: '_AllCourseScreenState');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 30;
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: widget.argument?.title ?? 'Khoá học nổi bật',
        icon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: widget.argument?.haveIconHot == true
              ? Image.asset(
                  IconConst.hot,
                  width: 18,
                  height: 24,
                )
              : const SizedBox(),
        ),
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: GridView.builder(
        itemCount: _allCourseModel.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: _itemWidth / _itemHeight,
        ),
        itemBuilder: (context, index) {
          return CategoryDetailWidgetItemProduct(
            itemWidth: _itemWidth,
            courseModel: _allCourseModel[index],
          );
        },
      ),
    );
  }
}
