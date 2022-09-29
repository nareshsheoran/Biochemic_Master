class MedicineNameModel {
  String? id;
  String? remName;

  MedicineNameModel({this.id, this.remName});

  MedicineNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remName = json['rem_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['rem_name'] = this.remName;
    return data;
  }
}



