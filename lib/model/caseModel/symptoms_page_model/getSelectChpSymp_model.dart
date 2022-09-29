class GetSelectedChapterSymptomsModel {
  String? id;
  String? catId;
  String? remId;
  String? indication;
  String? isactive;

  GetSelectedChapterSymptomsModel(
      {this.id, this.catId, this.remId, this.indication, this.isactive});

  GetSelectedChapterSymptomsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    remId = json['rem_id'];
    indication = json['indication'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['rem_id'] = this.remId;
    data['indication'] = this.indication;
    data['isactive'] = this.isactive;
    return data;
  }
}
