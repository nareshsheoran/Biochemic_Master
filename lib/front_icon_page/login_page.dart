// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'dart:ui';
import 'package:biochemic_master/front_icon_page/model/LoginReq.dart';
import 'package:http/http.dart';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../auth/user_profile_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(
    text: "user1@gmail.com",
  );
  TextEditingController passwordController =
      TextEditingController(text: "123456");
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: Images.logoImg,
                    ),
                    const SizedBox(height: 10),
                    Text(Constant.language == '?lang=h' ? "लॉगिन" : "Login",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 6),
                        Text(
                          Constant.language == '?lang=h' ? "ईमेल" : "Email",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                        controller: emailController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            hintText: Constant.language == '?lang=h'
                                ? "ईमेल लिखे"
                                : 'Enter Email',
                            helperMaxLines: 2,
                            hintMaxLines: 2,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Constant.primaryColor)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constant.primaryColor))
                            // border: InputBorder.none
                            ),
                        validator: (value) {
                          if (value == null) {
                            return Constant.language == '?lang=h'
                                ? "कृपया ईमेल दर्ज करे"
                                : "Please Enter Email";
                          }
                          return null;
                        }),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 6),
                        Text(
                          Constant.language == '?lang=h'
                              ? "पासवर्ड"
                              : "Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                        obscureText: !showPassword,
                        controller: passwordController,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () => setState(
                                    () => showPassword = !showPassword),
                                color: Constant.primaryColor),
                            contentPadding:  EdgeInsets.all(16),
                            hintText: Constant.language == '?lang=h'
                                ? "पासवर्ड लिखे"
                                : 'Enter Password',
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Constant.primaryColor)),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constant.primaryColor))),
                        validator: (value) {
                          if (value == null) {
                            return Constant.language == '?lang=h'
                                ? "कृपया पासवर्ड दर्ज करे"
                                : "Please Enter Password";
                          }
                          return null;
                        }),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: ElevatedButton(
                            onPressed: () async {
                              // login(context);
                              if (_formKey.currentState!.validate()) {
                                // emailController.text = "user1@gmail.com";
                                // passwordController.text = "123456";
                                login();
                                // Navigator.pushNamed(
                                //     context, AppRoutes.FrontPage);

                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Constant.primaryColor),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: Text(
                                Constant.language == '?lang=h'
                                    ? "लॉगिन"
                                    : 'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.SignUpPage);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: Constant.language == '?lang=h'
                              ? "कोई खाता नहीं है? "
                              : "Don't have an account? ",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                          children: <TextSpan>[
                            TextSpan(
                              text: Constant.language == '?lang=h'
                                  ? " साइन अप"
                                  : " Sign Up",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future login() async {
    Uri myUri = Uri.parse(
        "${NetworkUtil.getLoginUrl}email=${emailController.text}&password=${passwordController.text}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("login Response: $response");
      debugPrint("login Response Body:   ${response.body}");
      debugPrint("login Status Code: ${response.statusCode}");

      if (response.body != null && response.body != "[]") {
        Fluttertoast.showToast(
            msg: Constant.language == '?lang=h'
                ? "सफलतापूर्वक लॉगिन हुआ"
                : "Login Successfully");
        LocalDataSaver.saveLoginData(true);

        List values = [];
        values = jsonDecode(response.body);
        List<LoginRequest> detailsList = [];
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              detailsList.add(LoginRequest.fromJson(map));
              setState(() {
                detailsList;
              });
            }
          }
        }

        LocalDataSaver.saveEmail(detailsList[0].email);
        LocalDataSaver.savePassword(detailsList[0].password);
        LocalDataSaver.saveID(detailsList[0].id);
        LocalDataSaver.saveName(detailsList[0].name);

        Constant.email = (await LocalDataSaver.getEmail())!;
        Constant.password = (await LocalDataSaver.getPassword())!;
        Constant.id = (await LocalDataSaver.getID())!;
        Constant.name = (await LocalDataSaver.getName())!;
        Navigator.pop(context);
        await Navigator.pushReplacementNamed(context, AppRoutes.FrontPage);
      } else {
        Fluttertoast.showToast(
            msg: Constant.language == "?lang=h"
                ? "अमान्य लॉगिन"
                : "Invalid Login");
      }
    }
  }
}

// LocalDataSaver.saveLoginData(true);
// LocalDataSaver.saveName(
// UserProfileModel().userName);
// LocalDataSaver.saveEmail(
// UserProfileModel().userEmail);
// LocalDataSaver.saveImg(
// UserProfileModel().userImg);
// LocalDataSaver.savePassword(
// UserProfileModel().userPassword);
//
//
// Constant.name = (await LocalDataSaver.getName());
// Constant.email = (await LocalDataSaver.getEmail());
// Constant.img = (await LocalDataSaver.getImg());
// Constant.password = (await LocalDataSaver.getPassword());
