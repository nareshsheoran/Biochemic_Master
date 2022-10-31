class FrontPageReq {
  String? id;
  String? text;
  String? language;
  String? isactive;

  FrontPageReq({this.id, this.text, this.language, this.isactive});

  FrontPageReq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    language = json['language'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['language'] = this.language;
    data['isactive'] = this.isactive;
    return data;
  }
}
