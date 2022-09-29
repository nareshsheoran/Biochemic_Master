class IndicationModel {
  String? indication;
  String? id;
  String? rem_id;
  int? date;
  bool? isCheck=false;

  IndicationModel({this.indication,this.isCheck, this.id,this.date, this.rem_id});

  IndicationModel.fromJson(Map<String, dynamic> json) {
    indication = json['indication'];
    id = json['id'];
    rem_id = json['rem_id'];
    isCheck = json['isCheck'];
    date = json['date'] ?? 0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['indication'] = this.indication;
    data['id'] = this.id;
    data['rem_id'] = this.rem_id;
    data['isCheck'] = this.isCheck;
    data['date'] = this.date;
    return data;
  }
}
