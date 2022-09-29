class GetUnSelectedChapterSymptomsModel {
  String? id;
  String? catId;
  String? remId;
  String? indication;
  String? isactive;
  bool? isCheck = false;

  GetUnSelectedChapterSymptomsModel(
      {this.id, this.catId, this.remId,this.isCheck, this.indication, this.isactive});

  GetUnSelectedChapterSymptomsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    remId = json['rem_id'];
    indication = json['indication'];
    isactive = json['isactive'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['rem_id'] = this.remId;
    data['indication'] = this.indication;
    data['isactive'] = this.isactive;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
