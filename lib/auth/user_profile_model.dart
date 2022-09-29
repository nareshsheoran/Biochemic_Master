class UserProfileModel {
  String? userId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userImg;

  UserProfileModel({
    this.userId, this.userName, this.userPassword, this.userEmail, this.userImg
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    userName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userId;
    data['name'] = this.userName;
    return data;
  }
}
