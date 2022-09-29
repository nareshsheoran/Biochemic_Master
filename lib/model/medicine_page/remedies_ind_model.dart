class GetRemediesIndModel {
  String? remName;
  String? remId;
  String? categoryName;
  String? indication;

  GetRemediesIndModel(
      {this.remName, this.remId, this.categoryName, this.indication});

  GetRemediesIndModel.fromJson(Map<String, dynamic> json) {
    remName = json['rem_name'];
    remId = json['rem_id'];
    categoryName = json['category_name'];
    indication = json['indication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rem_name'] = this.remName;
    data['rem_id'] = this.remId;
    data['category_name'] = this.categoryName;
    data['indication'] = this.indication;
    return data;
  }
}
