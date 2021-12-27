import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/model/theme_model.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:flutter/material.dart';

class CourseTheme extends StatelessWidget {
  final List<ThemeModel> themes;
  final Function(ThemeModel themeModel) onTap;

  const CourseTheme({Key? key, required this.themes, required this.onTap})
      : super(key: key);

  List<Widget> mapDataToWidget() {
    List<Widget> result = [];
    List<List<ThemeModel>> groupThemeModel = [];

    for (var i = 0; i < themes.length; i += 3) {
      if (i + 3 < themes.length) {
        groupThemeModel.add(themes.sublist(i, i + 3));
      } else {
        groupThemeModel.add(themes.sublist(i, themes.length));
      }
    }
    for (final obj in groupThemeModel) {
      // List<Widget> _itemWidget = [];
      result.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: obj
                .map((e) => _item(e, onTap, gradient: (e.id ?? 0) % 2 == 0))
                .toList(),
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: mapDataToWidget(),
    );
  }

  Widget _item(ThemeModel themeModel, Function(ThemeModel themeModel) onTap,
      {bool gradient = false}) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          onTap(themeModel);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                gradient ? IconConst.bg_gradient1 : IconConst.bg_gradient2,
                height: 84,
              ),
            ),
            Positioned.fill(
                child: Align(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    themeModel.name ?? '',
                    style: AppTextTheme.medium.copyWith(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }
}
