class LessonModel {
  String? name;
  String? content;
  String? clipLink;
  String? clipCover;
  int? nextId;
  int? preId;
  List<Lessons>? lessons;
  int? clipTime;
  LessonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    content = json['content'];
    clipLink = json['clip_link'];
    clipCover = json['clip_cover'];
    clipTime = json['clip_time'];
    nextId = json['next_id'];
    preId = json['pre_id'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons?.add(new Lessons.fromJson(v));
      });
    }
  }
}

class Lessons {
  String? partName;
  List<LessonList>? lessonList;

  Lessons.fromJson(Map<String, dynamic> json) {
    partName = json['part_name'];
    if (json['lesson_list'] != null) {
      lessonList = <LessonList>[];
      json['lesson_list'].forEach((v) {
        lessonList?.add(LessonList.fromJson(v));
      });
    }
  }
}

class LessonList {
  int? id;
  String? name;

  LessonList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
