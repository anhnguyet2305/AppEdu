class CourseModel {
  int? id;
  String? name;
  String? mentor;
  String? image;
  int? rated;
  dynamic info;

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mentor = json['mentor'];
    image = json['image'];
    rated = json['rated'];
    info = json['info'];
  }
}
