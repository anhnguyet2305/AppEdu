import 'package:intl/intl.dart';

class NotificationModel {
  int? id;
  String? name;
  String? link;
  bool readed = false;
  String? time;
  String? dateTimeText;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    readed = json['readed'] ?? false;
    time = json['time'];
    DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
    DateFormat dateFormat2 = DateFormat('hh:mm | dd/MM/yyyy');
    if (time?.isNotEmpty ?? false) {
      dateTimeText = dateFormat2.format(dateFormat.parse(time!));
    }
  }
}
