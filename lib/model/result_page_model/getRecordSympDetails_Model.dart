// ignore_for_file: unnecessary_this, prefer_collection_literals

class RecordRemCountDetailsModel {
  String? indication;
  String? categoryName;

  RecordRemCountDetailsModel({
    this.indication,
    this.categoryName,
  });

  RecordRemCountDetailsModel.fromJson(Map<String, dynamic> json) {
    indication = json['indication'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['indication'] = this.indication;
    data['category_name'] = this.categoryName;
    return data;
  }
}
