import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:flutter/material.dart';

class DialogNorComponent extends StatefulWidget {
  const DialogNorComponent({
    Key? key,
  }) : super(key: key);

  @override
  _DialogNorComponentState createState() => _DialogNorComponentState();
}

class _DialogNorComponentState extends State<DialogNorComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bạn có chắc muốn nộp bài?',
              style: AppTextTheme.normalRoboto,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            MyButton(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/ExamResultsScreen', (Route<dynamic> route) => false);
                },
                titleButton: 'Nộp bài'),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                //do something
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hủy',
                  style: AppTextTheme.normalGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
