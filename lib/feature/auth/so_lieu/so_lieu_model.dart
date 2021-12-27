class SoLieuModel {
  String? address1;
  List<Data1>? data1;

  SoLieuModel.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    if (json['data_1'] != null) {
      data1 = <Data1>[];
      json['data_1'].forEach((v) {
        data1?.add(new Data1.fromJson(v));
      });
    }
  }
}

class Data1 {
  String? address2;
  Data2? data2;

  Data1.fromJson(Map<String, dynamic> json) {
    address2 = json['address_2'];
    data2 = json['data_2'] != null ? new Data2.fromJson(json['data_2']) : null;
  }
}

class Data2 {
  String? vNgGi;
  String? pLCGiWo;
  String? giaTCNNQuyI;
  String? giaTCNN;

  Data2.fromJson(Map<String, dynamic> json) {
    vNgGi = json['Vùng gió'];
    pLCGiWo = json['Áp lực gió Wo'];
    giaTCNNQuyI = json['Gia tốc nền quy đổi'];
    giaTCNN = json['Gia tốc nền'];
  }

  String toString() {
    return ''
        '${vNgGi != null ? 'Vùng gió: $vNgGi\n' : ''}'
        '${pLCGiWo != null ? 'Áp lực gió Wo: $pLCGiWo\n' : ''}'
        '${giaTCNNQuyI != null ? 'Gia tốc nền quy đổi: $giaTCNNQuyI\n' : ''}'
        '${giaTCNN != null ? 'Gia tốc nền: $giaTCNN\n' : ''}'
        '';
  }
}
