class GetSympCountModel {
  String? count;

  GetSympCountModel({this.count});

  GetSympCountModel.fromJson(Map<String, dynamic> json) {
    count = json['count(*)'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count(*)'] = this.count;
    return data;
  }
}
