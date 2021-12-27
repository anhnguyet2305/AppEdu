class VatLieuModel {
  String? address1;
  List<Data1>? data1;

  VatLieuModel.fromJson(Map<String, dynamic> json) {
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
    data2 = json['data_2'] != null ? new Data2.fromJson(json['data_2']) : null;
  }
}

class Data2 {
  String? rb;
  String? rbt;
  String? e;
  String? rs;
  String? rsc;
  String? rsw;
  String? rsy;

  Data2.fromJson(Map<String, dynamic> json) {
    rb = json['Rb'];
    rbt = json['Rbt'];
    e = json['E'];
    rs = json['Rs'];
    rsc = json['Rsc'];
    rsw = json['Rsw'];
    rsy = json['Rsy'];
  }

  String toString() {
    return ''
        '${rb != null ? 'Rb: $rb\n' : ''}'
        '${rbt != null ? 'Rbt: $rbt\n' : ''}'
        '${rs != null ? 'Rs: $rs\n' : ''}'
        '${rsc != null ? 'Rsc: $rsc\n' : ''}'
        '${rsw != null ? 'Rsw: $rsw\n' : ''}'
        '${rsy != null ? 'Rsy: $rsy\n' : ''}'
        '${e != null ? 'E: $e' : ''}'
        '';
  }
}
