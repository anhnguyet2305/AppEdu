import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BottomSheetDatePicker extends StatefulWidget {
  final Function(DateTime? date)? onDateTimeChanged;

  BottomSheetDatePicker({Key? key, this.onDateTimeChanged}) : super(key: key);

  @override
  _BottomSheetDatePickerState createState() => _BottomSheetDatePickerState();
}

class _BottomSheetDatePickerState extends State<BottomSheetDatePicker> {
  DateTime? _dateTime;

  @override
  void initState() {
    _dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (date) {
              _dateTime = date;
            },
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: CupertinoButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.pop(context);
                widget.onDateTimeChanged!(_dateTime);
              },
            ),
          ),
        ],
      ),
    );
  }
}
