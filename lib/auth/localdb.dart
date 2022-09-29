import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String idKey = "IdKey";
  static String nameKey = "NameKey";
  static String emailKey = "EmailKey";
  static String passwordKey = "PasswordKey";
  static String imgKey = "ImgKey";
  static String logKey = "LogKey";

  static Future<bool> saveID(String? userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(idKey, userID!);
  }

  static Future<String?> getID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(idKey);
  }

 static Future<bool> saveName(String? username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nameKey, username!);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nameKey);
  }

  static Future<bool> saveEmail(String? userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(emailKey, userEmail!);
  }

  static Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(emailKey);
  }

  static Future<bool> saveImg(String? userImg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(imgKey, userImg!);
  }

  static Future<String?> getImg() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(imgKey);
  }

  static Future<bool> savePassword(String? userPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(passwordKey, userPassword!);
  }

  static Future<String?> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(passwordKey);
  }

  static Future<bool> saveLoginData(bool? isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logKey, isUserLoggedIn!);
  }

  static Future<bool?> getLogData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(logKey);
  }
}
