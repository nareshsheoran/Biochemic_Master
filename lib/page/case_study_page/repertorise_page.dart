// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:core';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/model/repertories_page_model/getResultModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RepertorisePage extends StatefulWidget {
  const RepertorisePage({Key? key}) : super(key: key);

  @override
  State<RepertorisePage> createState() => _RepertorisePageState();
}

class _RepertorisePageState extends State<RepertorisePage> {
  bool isLoading = false;

  Future removeSymptoms() async {
    Uri myUri = Uri.parse("${NetworkUtil.getRemoveSymp}user_id=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("removeSymptoms Status Code: ${response.statusCode}");
      debugPrint("removeSymptoms Response Body: ${response.body}");

      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (map != null && map['message'] != null) {
        Fluttertoast.showToast(msg: map['message']);
        if (response.statusCode == 200 &&
            map['message'] == "Symptoms Cleared") {
          getResultModelList.clear();

          // for (int i = 0; i < getResultModelList.length; i++) {
          //   getResultModelList[i].rem = "";}
          setState(() {});
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.ChapterPage);
        }
      }
    }
  }

  List<GetResultModel> getResultModelList = [];
  List ramNameList = [];
  List ramCountList = [];

  Future getRemCount() async {
    // getResultModelList.clear();
    setState(() {
      isLoading = true;
    });
    http.Response response = await http
        .get(Uri.parse("${NetworkUtil.getRemCount}user_id=${Constant.id}"));

    if (response.statusCode == 200) {
      debugPrint("getRemCount Status Code: ${response.statusCode}");
      debugPrint("getRemCount Response Body: ${response.body}");

      List<dynamic> values = <dynamic>[];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            getResultModelList.add(GetResultModel.fromJson(map));
            setState(() {});

            String getRamNameId = getResultModelList[i].rem!.split('-')[0];
            print("getNameId: $getRamNameId");
            ramNameList.add(getRamNameId);

            String getRamCountId =
                getResultModelList[i].rem!.split(',')[0].split("-")[1];
            print("getCountId: $getRamCountId");
            ramCountList.add(getRamCountId);

            // subsId = subsId.substring(1, subsId.length - 1);
            // print("subsId: $subsId");
            // print("subsId: $subsId");
            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }
  }

  // }

  @override
  void initState() {
    getRemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Remedies"),
        centerTitle: true,
        backgroundColor: Constant.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (isLoading)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                          ),
                        ))
                    : ListView.builder(
                        itemCount: ramCountList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.ResultPage,
                                  arguments: getResultModelList[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: CardShape.elevation,
                                color: Constant.primaryColor,
                                shadowColor: Constant.primaryColor,
                                shape: CardShape.shape,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 6),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 24,
                                        // backgroundImage: Images.logoImg,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text("Rank",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Constant
                                                          .primaryColor)),
                                              Text((index + 1).toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Constant
                                                          .primaryColor)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (ramNameList[index]),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            ("Symptoms Covered- ${ramCountList[index]}"),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Warning',
                      titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      desc: 'Are you sure to remove all symptoms record?',
                      descTextStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      buttonsTextStyle: const TextStyle(color: Colors.black),
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        setState(() {
                          removeSymptoms();
                        });
                      },
                    ).show();
                  },
                  child: Card(
                    color: Colors.red,
                    shadowColor: Constant.primaryColor,
                    shape: CardShape.shape,
                    elevation: CardShape.elevation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 8),
                      child: Row(
                        children: const [
                          Text(
                            "Remove Symptoms",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// if (getRemCountModelList.length == 12) {
//   Map listMap = {};
//   for (var i = 0; i < getRemCountModelList.length; i++) {
//     listMap[medList[i]] = getRemCountModelList[i];
//     List<String> yourDetails = listMap.keys.map((e) {
//       return "MedList ${medList[i]} nd Count ${getRemCountModelList[i].count}";
//     }).toList();
//     yourDetails.forEach((element) {
//       print(element);
//       print("d ${yourDetails[i]}");
//     });
//   }
// }

// if (getRemCountModelList.length == medList.length) {
//   getRemCountModelList.sort((a, b) {
//     return b.count.compareTo(a.count);
//   });
//   debugPrint("Count ${getRemCountModelList[0].count}");
//   max = getRemCountModelList[0].count;
//   debugPrint(max);
// }

// medList.sort((a, b) {
//   return b.toString()
//       .compareTo(a.toString());
// });
