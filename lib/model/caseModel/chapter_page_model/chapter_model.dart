class ChapterModel {
  String? id;
  String? chapter;
  String? img;

  ChapterModel({this.id, this.chapter,this.img});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chapter = json['chapter'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['chapter'] = this.chapter;
    data['img'] = this.img;
    return data;
  }
}
