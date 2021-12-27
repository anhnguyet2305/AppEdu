import 'package:app_edu/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:app_edu/common/bloc/event_bus/event_bus_state.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector_container.dart';

const heightItem = 58.0;

class BottomNavigation extends StatefulWidget {
  final List<Widget> tabViews;
  final List<String> icons;
  final Color activeColor;
  final Color inActiveColor;
  final double iconSize;
  final int initIndex;
  final int countItem;
  final Function? iconCenterTap;

  BottomNavigation({
    Key? key,
    required this.tabViews,
    required this.icons,
    this.initIndex = 0,
    this.activeColor = AppColors.greenText,
    this.inActiveColor = AppColors.grey5,
    this.iconSize = 24.0,
    this.countItem = 0,
    this.iconCenterTap,
  })  : assert(tabViews != null, 'Tab view not be null'),
        assert(icons != null, 'Icons not be null'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List<String> _icon = [];
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    selectedIndex = widget.initIndex;
    _icon = widget.icons;
    _pageController.addListener(() {
      double? index = _pageController.page;
      if (index == 0.0 || index == 1.0 || index == 2.0 || index == 3.0) {
        setState(() {
          selectedIndex = index?.toInt() ?? 0;
        });
      }
    });
    super.initState();
  }

  void changeToTabIndex(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.jumpToPage(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _icon.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final source = entry.value;
        final isSelected = index == selectedIndex;
        return source != null
            ? Expanded(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    highlightColor: AppColors.grey6,
                    splashColor: AppColors.grey6,
                    onTap: () {
                      if (!isSelected) {
                        changeToTabIndex(index);
                      }
                    },
                    child: BlocBuilder(
                      bloc: injector<EventBusBloc>(),
                      builder: (_, state) {
                        var count;
                        if (state is EventBusRequestInitDataNotificationState &&
                            index == 2) {
                          count = state.count;
                        }
                        return Stack(
                          children: [
                            Container(
                              height: heightItem,
                              child: Center(
                                child: Image.asset(
                                  '$source',
                                  width: widget.iconSize,
                                  height: widget.iconSize,
                                  color: isSelected
                                      ? widget.activeColor
                                      : widget.inActiveColor,
                                ),
                              ),
                            ),
                            count != null
                                ? Positioned(
                                    right: 26,
                                    top: 12,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$count',
                                          style: AppTextTheme.smallGrey
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ))
                                : const SizedBox()
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            : const Spacer();
      },
    ).toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: BlocListener<EventBusBloc, EventBusState>(
        bloc: injector<EventBusBloc>(),
        listener: (_, state) {},
        child: PageView(
          controller: _pageController,
          children: widget.tabViews,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, -3),
                spreadRadius: 3,
                blurRadius: 6)
          ], color: AppColors.white),
          child: Row(
            children: tabs,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ),
      ),
    );
  }
}
