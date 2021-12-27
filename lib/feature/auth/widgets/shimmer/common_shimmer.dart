import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/feature/auth/widgets/shimmer/item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmer extends StatelessWidget {
  final Widget? child;
  final int numberItem;

  CommonShimmer({Key? key, this.child, this.numberItem = 3}) : super(key: key);

  List<Widget> _initData() {
    List<Widget> _listWIdget = [];
    for (int i = 0; i < numberItem; i++) {
      _listWIdget.add(ItemShimmer());
    }
    return _listWIdget;
  }

  @override
  Widget build(BuildContext context) {
    var _listWidget = _initData();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Shimmer.fromColors(
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFF5F5F5),
        child: Column(
          children: _listWidget,
        ),
      ),
    );
  }
}
