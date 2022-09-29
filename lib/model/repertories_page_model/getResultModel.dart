class GetResultModel {
  String? rem;

  GetResultModel({this.rem});

  GetResultModel.fromJson(Map<String, dynamic> json) {
    rem = json['rem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['rem'] = this.rem;
    return data;
  }
}
