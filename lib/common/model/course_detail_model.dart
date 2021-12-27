
import 'package:app_edu/common/model/lesson_model.dart';

class CourseDetailModel {
  String? name;
  String? mentor;
  String? image;
  int? rated;
  dynamic info;
  String? content;
  List<Lessons>? lessons;
  int? rates;
  String? time;

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mentor = json['mentor'];
    image = json['image'];
    rated = json['rated'];
    rated = json['rated'];
    info = json['info'];
    content = json['content'];
    if (json['time'] != null) {
      time = _printDuration(Duration(seconds: json['time']));
    }
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons?.add(new Lessons.fromJson(v));
      });
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
