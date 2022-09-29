class MyCasesModel {
  String? id;
  String? userId;
  String? date;
  String? isactive;

  MyCasesModel({this.id, this.userId, this.date, this.isactive});

  MyCasesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['isactive'] = this.isactive;
    return data;
  }
}
