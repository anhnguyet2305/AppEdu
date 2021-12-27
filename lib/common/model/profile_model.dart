class ProfileModel {
  String? name;
  String? email;
  String? image;
  dynamic sdt;
  dynamic birthday;
  bool? vipMember;
  dynamic vipExpdate;
  String? apiToken;

  ProfileModel.fromJson(Map json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    sdt = json['sdt'];
    birthday = json['birthday'];
    vipMember = json['vip_member'];
    vipExpdate = json['vip_expdate'];
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['sdt'] = this.sdt;
    data['birthday'] = this.birthday;
    data['vip_member'] = this.vipMember;
    data['vip_expdate'] = this.vipExpdate;
    data['api_token'] = this.apiToken;
    return data;
  }
}
