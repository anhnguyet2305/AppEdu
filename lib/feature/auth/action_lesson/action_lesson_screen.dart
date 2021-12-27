import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:app_edu/common/customs/appbar_custom.dart';
import 'package:app_edu/common/customs/button_custom.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/model/question_model.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/feature/auth/result/result_screen.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../injector_container.dart';
import '../../routes.dart';
import 'action_lesson_item.dart';

class ActionLessonScreen extends StatefulWidget {
  final int? id;

  const ActionLessonScreen({Key? key, this.id}) : super(key: key);

  @override
  _ActionLessonScreenState createState() => _ActionLessonScreenState();
}

class _ActionLessonScreenState extends State<ActionLessonScreen> {
  List<QuestionModel> _questiones = [];
  List<String> _result = [];
  int _currentIndex = 0;
  int? _childIndex;
  bool _enable = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>()
          .get('get-sathach-cchn?isfull=${widget.id ?? 0}');
      data['data'].forEach((e) {
        _questiones.add(QuestionModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  void _onAnsware(String text, int childIndex) async {
    _childIndex = childIndex;
    setState(() {});
    _result.add(text);
    await Future.delayed(Duration(milliseconds: 200));
    if (_questiones.length - 1 == _currentIndex) {
      setState(() {
        _enable = true;
      });
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        content: 'Đã hoàn thành tất cả câu hỏi, hãy bấm nộp bài để hoàn tất',
        type: SnackBarType.success,
      ));
      return;
    }
    _currentIndex++;
    _childIndex = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _numbers = [];
    if (_questiones.isNotEmpty) {
      for (var i = 0; i < _questiones.length; i++) {
        _numbers.add(_number(i));
      }
    }
    return MyScaffoldSafe(
      columnWidget: Column(
        children: [
          MyAppBar(
            title: '${widget.id == 0 ? 'Bài thi luật' : 'Bài thi đầy đủ'}',
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Wrap(
                  children: _numbers,
                  runSpacing: 8,
                ),
                _questiones.isNotEmpty
                    ? ActionLessonItem(
                        questionModel: _questiones[_currentIndex],
                        currentIndex: _currentIndex + 1,
                        onAnswer: _onAnsware,
                        childIndex: _childIndex,
                      )
                    : const SizedBox(),
                // const SizedBox(height: 80),
              ],
            ),
          )
        ],
      ),
      bottomNav: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.grey4),
          ),
        ),
        child: MyButton(
          onTap: () async {
            final data =
                await Routes.instance.navigateTo(RouteName.resultScreen,
                    arguments: ArgumentResultScreen(
                      questions: _questiones,
                      results: _result,
                    ));
            Routes.instance.pop(result: data);
          },
          enable: _enable,
          titleButton: 'Nộp bài',
        ),
      ),
    );
  }

  Widget _number(int index) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 8),
      decoration: index >= _currentIndex + 1
          ? BoxDecoration(
              border: Border.all(color: AppColors.grey5),
              borderRadius: BorderRadius.circular(8),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryColor),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppTextTheme.mediumBlack.copyWith(
            color: (index >= _currentIndex + 1)
                ? AppColors.grey7
                : AppColors.white,
          ),
        ),
      ),
    );
  }
}
