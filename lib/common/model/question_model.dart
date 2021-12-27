class QuestionModel {
  int? id;
  String? cauHoi;
  List<String>? dapAn;
  int? dapAnDung;
  String? cauTraLoi;

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cauHoi = json['cau_hoi'];
    dapAn = json['dap_an'].cast<String>();
    dapAnDung = json['dap_an_dung'];
  }
}
