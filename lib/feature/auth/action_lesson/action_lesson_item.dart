import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/model/question_model.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/custom_gesturedetactor.dart';
import 'package:flutter/material.dart';

class ActionLessonItem extends StatefulWidget {
  final QuestionModel questionModel;
  final int currentIndex;
  final int? childIndex;
  final Function(String text, int childIndex) onAnswer;

  const ActionLessonItem(
      {Key? key,
      this.childIndex,
      required this.questionModel,
      required this.currentIndex,
      required this.onAnswer})
      : super(key: key);

  @override
  _ActionLessonItemState createState() => _ActionLessonItemState();
}

class _ActionLessonItemState extends State<ActionLessonItem> {
  int? _currentIndex;

  void _onTap(String text, int index) {
    widget.onAnswer(text, index);
    setState(() {
      // _currentIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    _currentIndex = null;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            '''Câu hỏi ${widget.currentIndex}: ${widget.questionModel.cauHoi}''',
            style: AppTextTheme.normalBlack,
          ),
          const SizedBox(
            height: 12,
          ),
          _itemWidget('${widget.questionModel.dapAn?[0]}', 1, _onTap),
          _itemWidget('${widget.questionModel.dapAn?[1]}', 2, _onTap),
          _itemWidget('${widget.questionModel.dapAn?[2]}', 3, _onTap),
          _itemWidget('${widget.questionModel.dapAn?[3]}', 4, _onTap),
        ],
      ),
    );
  }

  Widget _itemWidget(
      String text, int index, Function(String text, int index) onTap) {
    return CustomGestureDetector(
      onTap: () {
        onTap(text, index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Image.asset(
              index == widget.childIndex ? IconConst.tick : IconConst.un_tick,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: AppTextTheme.mediumBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
