// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:flutter/material.dart';

class LanguageSelect extends StatefulWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  bool isEngChecked = false;
  bool isHinChecked = false;
  String? isLanguage;

  @override
  void initState() {
    Constant.language = '';
    LocalDataSaver.saveLanguage("");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 65,
                backgroundImage: Images.logoImg),
            SizedBox(height: 16),
            Text(Constant.language == '?lang=h' ? "बायोकेमिक मास्टर" : appName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Column(
                children: [
                  Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                          Constant.language == '?lang=h'
                              ? "भाषा चुने"
                              : "Select Language",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Constant.primaryColor,
                              fontSize: 20))),
                  SizedBox(height: 10),
                  Card(
                    color: Constant.primaryColor,
                    shape: CardShape.shape,
                    elevation: CardShape.elevation - 4,
                    shadowColor: Constant.primaryColor,
                    child: RadioListTile(
                      activeColor: Colors.white,
                      title: isLanguage == "h"
                          ? Text("हिन्दी",
                          style: TextStyle(color: Colors.white))
                          : Text("हिन्दी"),
                      value: "h",
                      groupValue: isLanguage,
                      onChanged: (value) {
                        setState(() {
                          isLanguage = value.toString();
                          languageSelect(value.toString());
                        });
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.FrontPage);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: Constant.primaryColor,
                    shape: CardShape.shape,
                    elevation: CardShape.elevation - 4,
                    shadowColor: Constant.primaryColor,
                    child: RadioListTile(
                      activeColor: Colors.white,
                      title: isLanguage == "e"
                          ? Text("English",
                          style: TextStyle(color: Colors.white))
                          : Text("English"),
                      value: "e",
                      groupValue: isLanguage,
                      onChanged: (value) {
                        setState(() {
                          isLanguage = value.toString();
                          languageSelect(value.toString());
                        });
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.FrontPage);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future languageSelect(value) async {
    LocalDataSaver.saveLanguage("?lang=${value.toString()}");
    Constant.language = (await LocalDataSaver.getLanguage())!;
    print("Language::: ${Constant.language}");
  }
}
