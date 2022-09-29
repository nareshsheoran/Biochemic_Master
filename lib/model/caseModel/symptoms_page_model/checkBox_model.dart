class CheckBoxModel {
  String? id;
  String? device_id;
  String? indi_id;
  String? rem_id;
  String? cat_id;
  bool? isCheck;
  String? createdOn;

  CheckBoxModel(
      {this.id,
        this.device_id,
        this.indi_id,
        this.rem_id,
        this.cat_id,
        this.createdOn});

  CheckBoxModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    device_id = json['device_id'];
    indi_id = json['indi_id'];
    rem_id = json['rem_id'];
    cat_id = json['cat_id'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.device_id;
    data['indi_id'] = this.indi_id;
    data['rem_id'] = this.rem_id;
    data['cat_id'] = this.cat_id;
    data['created_on'] = this.createdOn;
    return data;
  }
}
