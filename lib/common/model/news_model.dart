import 'package:intl/intl.dart';
class NewsModel {
  String? name;
  String? link;
  String? time;

  String? dateTimeText;
  NewsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    time = json['time'];
    DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
    DateFormat dateFormat2 = DateFormat('mm:hh | dd/MM/yyyy');
    if(time?.isNotEmpty??false){
      dateTimeText = dateFormat2.format(dateFormat.parse(time!));
    }
  }

}