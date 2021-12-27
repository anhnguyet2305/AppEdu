class ThemeModel{
  int? id;
  String? name;

  ThemeModel.fromJson(Map<String,dynamic> input){
    id = input['id'];
    name = input['name'];
  }
}