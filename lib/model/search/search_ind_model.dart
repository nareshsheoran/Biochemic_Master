class SearchIndModel {
  String? remName;
  String? id;

  SearchIndModel({this.remName, this.id});

  SearchIndModel.fromJson(Map<String, dynamic> json) {
    remName = json['rem_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rem_name'] = this.remName;
    data['id'] = this.id;
    return data;
  }
}
