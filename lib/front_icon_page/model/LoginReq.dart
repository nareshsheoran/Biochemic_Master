
class LoginRequest {
  String? id;
  String? email;
  String? name;
  String? password;
  String? isactive;

  LoginRequest({this.id, this.email, this.name, this.password, this.isactive});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['isactive'] = this.isactive;
    return data;
  }
}

