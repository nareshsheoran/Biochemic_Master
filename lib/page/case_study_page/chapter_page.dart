// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:biochemic_master/model/caseModel/chapter_page_model/chapter_model.dart';
import 'package:biochemic_master/model/caseModel/chapter_page_model/getSympCountModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({Key? key}) : super(key: key);

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  bool isLoading = false;
  List getSelectedSymptomsList = [];

  var checkId =
      (Constant.id != '' || Constant.id == null || Constant.id.isEmpty);

  List<GetSympCountModel> getSympCountList = [];

  Future getSympCount() async {
    http.Response response = await http
        .get(Uri.parse("${NetworkUtil.getSympCountUrl}user_id=${Constant.id}"));

    if (response.statusCode == 200) {
      debugPrint("getSympCount Status Code: ${response.statusCode}");
      debugPrint("getSympCount Response Body: ${response.body}");

      List<dynamic> values = <dynamic>[];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            getSympCountList.add(GetSympCountModel.fromJson(map));
            getSympCountList;
            if (mounted) {
              setState(() {
                getSympCountList;
              });
            } else {
              getSympCountList;
            }
          }
        }
      }
    }
  }

  List<ChapterModel> chapterList = [];

  Future getChapter() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(NetworkUtil.chapterUrlCh + Constant.language!);
    print(Constant.language);
    print(myUri);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("Chapter Status Code: ${response.statusCode}");
      debugPrint("Chapter Response Body: ${response.body}");
      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            chapterList.add(ChapterModel.fromJson(map));
            chapterList;
          }
        }
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    }
  }

  Future languageSelect() async {
    Constant.language = (await LocalDataSaver.getLanguage())!;
    print("Chap Language::: ${Constant.language}");
    getChapter();
    getSympCount();
  }

  @override
  void initState() {
    languageSelect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: Constant.language == '?lang=h'
            ? Text("मामले का अध्ययन")
            : Text("Case Study"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 4.5,
                      vertical: 10),
                  child: Text(
                    Constant.language == "?lang=h"
                        ? "अध्याय चुनें"
                        : "Select Chapter",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          (isLoading)
              ? Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child:  Center(
                      child: CircleProgressIndicator.circleIndicator
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: GridView.builder(
                      itemCount: chapterList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.1,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ChapterModel item = chapterList[index];
                        // getSympCount();
                        return buildCard(context, item);
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 8),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Constant.primaryColor),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: GestureDetector(
                  onTap: () {
                    (getSympCountList.isEmpty ||
                            getSympCountList[0].count == '0' ||
                            getSympCountList[0].count == null ||
                            Constant.id == null ||
                            Constant.id.isEmpty ||
                            Constant.id == '')
                        ? Fluttertoast.showToast(
                            msg: Constant.language == "?lang=h"
                                ? "कृपया लक्षण चुने"
                                : 'Please Select Symptoms')
                        : Navigator.pushNamed(
                            context, AppRoutes.SelectedSymptomsPage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (isLoading == true ||
                              Constant.id == null ||
                              Constant.id == '' ||
                              getSympCountList.isEmpty ||
                              getSympCountList[0].count == '0' ||
                              getSympCountList[0].count == null)
                          ? Text(
                              Constant.language == "?lang=h"
                                  ? "चुने हुए लक्षण: 0"
                                  : "Selected Symptoms: 0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              Constant.language == "?lang=h"
                                  ? "चुने हुए लक्षण: ${getSympCountList[0].count}"
                                  : "Selected Symptoms: ${getSympCountList[0].count}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Constant.primaryColor,
                      shadowColor: Constant.primaryColor,
                      shape: CardShape.shape,
                      elevation: CardShape.elevation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 3.8,
                            vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    (getSympCountList.isEmpty ||
                                            getSympCountList[0].count == "0" ||
                                            getSympCountList[0]
                                                    .count
                                                    .toString() ==
                                                null ||
                                            Constant.id == null ||
                                            Constant.id.isEmpty ||
                                            Constant.id == '')
                                        ? Fluttertoast.showToast(
                                            msg: Constant.language == "?lang=h"
                                                ? "कृपया लक्षण चुने"
                                                : 'Please Select Symptoms')
                                        : (Navigator.pushNamed(context,
                                            AppRoutes.RepertorisePage));
                                  },
                                  child: Text(
                                    Constant.language == "?lang=h"
                                        ? "रेपोट्राइज़"
                                        : "Repertorise",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, ChapterModel item) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.SymptomsPage,
                    arguments: item);
              },
              child: Card(
                shadowColor: Constant.primaryColor,
                elevation: CardShape.elevation,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    // backgroundImage: NetworkImage(item.img!),
                    backgroundImage: NetworkImage(
                        "https://mettlecrowsolutions.com/apps/apis/biochem_newW/images/img.png"),
                  ),
                ),
              )),
          SizedBox(height: 2),
          Center(
              child: Text(
            item.chapter!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}

// (getSympCountList.isEmpty ||
//         getSympCountList[0].count == '0' ||
//         getSympCountList[0].count == null)
//     ? const Text(
//         "Selected Symptoms: 0",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             fontSize: 18, fontWeight: FontWeight.bold),
//       )
//     : Text(
//         "Selected Symptoms: ${getSympCountList[0].count}",
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//             fontSize: 18, fontWeight: FontWeight.bold),
//       )

// var index = 0;
// for (var i = 0; i < medList.length; i++) {
//   index = i;}
