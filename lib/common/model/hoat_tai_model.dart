class HoatTaiModel {
  String? address1;
  List<Data1>? data1;

  HoatTaiModel.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    if (json['data_1'] != null) {
      data1 = <Data1>[];
      json['data_1'].forEach((v) {
        data1?.add(Data1.fromJson(v));
      });
    }
  }
}

class Data1 {
  String? address2;
  Data2? data2;

  Data1.fromJson(Map<String, dynamic> json) {
    address2 = json['address_2'];
    data2 = json['data_2'] != null ? Data2.fromJson(json['data_2']) : null;
  }
}

class Data2 {
  String? toNPhN;
  String? dIHN;

  Data2.fromJson(Map<String, dynamic> json) {
    toNPhN = json['Toàn phần'];
    dIHN = json['Dài hạn'];
  }
}
