class SelectedSymptomsModel {
  String? indication;
  String? categoryName;
  String? remName;
  String? indiId;

  SelectedSymptomsModel(
      {this.indication, this.categoryName, this.remName, this.indiId});

  SelectedSymptomsModel.fromJson(Map<String, dynamic> json) {
    indication = json['indication'];
    categoryName = json['category_name'];
    remName = json['rem_name'];
    indiId = json['indi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indication'] = this.indication;
    data['category_name'] = this.categoryName;
    data['rem_name'] = this.remName;
    data['indi_id'] = this.indiId;
    return data;
  }
}
