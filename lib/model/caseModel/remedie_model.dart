class RemediesModel {
  String? indication;
  String? id;
  String? remId;

  RemediesModel({this.indication, this.id, this.remId});

  RemediesModel.fromJson(Map<String, dynamic> json) {
    indication = json['indication'];
    id = json['id'];
    remId = json['rem_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['indication'] = this.indication;
    data['id'] = this.id;
    data['rem_id'] = this.remId;
    return data;
  }
}
