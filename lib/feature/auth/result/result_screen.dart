import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/model/question_model.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class ArgumentResultScreen {
  final List<QuestionModel>? questions;
  final List<String>? results;

  ArgumentResultScreen({this.questions, this.results});
}

class ResultScreen extends StatefulWidget {
  final ArgumentResultScreen? argument;

  const ResultScreen({Key? key, this.argument}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    List<QuestionModel> _question = widget.argument?.questions ?? [];
    List<String> _result = widget.argument?.results ?? [];
    List<Widget> _itemsWidget = [];
    for (var i = 0; i < _question.length; i++) {
      final obj = _question[i];
      if (obj.dapAn?[(obj.dapAnDung ?? 1) - 1] != _result[i]) {
        _itemsWidget.add(
          _questionItem(_question[i], i + 1, _result[i]),
        );
      }
    }
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Kết quả thi sát hạch CCHN',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Kết quả',
                    style: AppTextTheme.mediumBlack,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Bạn đã hoàn thành kết quả bài thi và dưới đây là kết quả',
                    style: AppTextTheme.normalBlack,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tổng điểm',
                              style: AppTextTheme.normalBlack,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${_itemsWidget.length}/${_question.length}',
                              style: AppTextTheme.smallBlack,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kết quả',
                              style: AppTextTheme.normalBlack,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${_itemsWidget.length == _question.length ? 'Đạt' : 'Không đạt'}',
                              style: AppTextTheme.normalBlack.copyWith(
                                  color: _itemsWidget.length == _question.length
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ghi chú',
                              style: AppTextTheme.normalBlack,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '',
                              style: AppTextTheme.smallBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    children: _itemsWidget,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: MyButton(
                onTap: () {
                  Routes.instance.pop(result: true);
                },
                titleButton: 'Làm bài khác',
              ),
            ),
            bottom: 0,
            left: 0,
            right: 0,
          )
        ],
      ),
    );
  }

  Widget _questionItem(
      QuestionModel? questionModel, int index, String? danAnSai) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '''Câu hỏi $index: ${questionModel?.cauHoi}''',
          style: AppTextTheme.normalBlack,
        ),
        Text(
          '$danAnSai',
          style: AppTextTheme.normalRobotoRed,
        ),
        Text(
          'Đáp án đúng: ${questionModel?.dapAn?[(questionModel.dapAnDung ?? 1) - 1]}',
          style: AppTextTheme.normalGreen,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
