// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/model/caseModel/chapter_page_model/chapter_model.dart';
import 'package:biochemic_master/model/caseModel/symptoms_page_model/checkBox_model.dart';
import 'package:biochemic_master/model/caseModel/symptoms_page_model/getSelectChpSymp_model.dart';
import 'package:biochemic_master/model/caseModel/symptoms_page_model/getUnSelectChpSymp_model.dart';
import 'package:biochemic_master/model/caseModel/symptoms_page_model/indication_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class SymptomsPage extends StatefulWidget {
  const SymptomsPage({Key? key}) : super(key: key);

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  var dateValue = '';
  ChapterModel? _chapterModel;
  bool isLoading = false;
  bool isAvailable = true;
  int index = 1;
  bool isFetching = false;

  Future fetchSymptomRecorded(int index) async {
    setState(() {
      isFetching = true;
    });
    Uri myUri = Uri.parse(
        // "${NetworkUtil.fetchSymptomRecordedUrl}device_id=$deviceValue&indi_id=${getUnSelectedSymptomsList[index].id}&rem_id=${getUnSelectedSymptomsList[index].remId}&cat_id=${_chapterModel.id}&created_on=$dateValue");
        "${NetworkUtil.fetchSymptomRecordedUrl}user_id=${Constant.id}&indi_id=${getUnSelectedSymptomsList[index].id}&rem_id=${getUnSelectedSymptomsList[index].remId}&cat_id=${_chapterModel!.id}&created_on=$dateValue");
    Response response = await get(myUri);

    if (response.statusCode == 200) {
      debugPrint("fetchSymptomRecorded Status Code: ${response.statusCode}");
      debugPrint("fetchSymptomRecorded Response Body: ${response.body}");

      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (map != null && map['message'] != null && map["success"] != null) {
        getSelectedChapterSymptoms();
        getUnSelectedChapterSymptoms();

        Fluttertoast.showToast(
            msg: Constant.language == '?lang=h'
                ? 'लक्षण दर्ज किया गया'
                : map['message']);

        if (response.statusCode == 200 &&
            map['message'] == "Symptom Recorded") {
          setState(() {
            isFetching = false;
          });
          Navigator.canPop(context);
        }
      }
    }
  }

  Future dateFormat() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    dateValue = formattedDate;
    debugPrint("DateFormat: $dateValue");
  }

  List<GetUnSelectedChapterSymptomsModel> getUnSelectedSymptomsList = [];
  bool isUnSelectAvailable = true;

  Future getUnSelectedChapterSymptoms() async {
    getUnSelectedSymptomsList.clear();
    setState(() {
      isLoading = true;
      isUnSelectAvailable = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.getUnSelectedChapterSymptomsUrl}cat_id=${_chapterModel!.id}&user_id=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("getUnSelectedSymptoms Status Code: ${response.statusCode}");
      debugPrint("getUnSelectedSymptoms Response Body: ${response.body}");

      List values = [];
      values = jsonDecode(response.body);
      if (response.body.isEmpty || response.body == "[]") {
        setState(() {
          isLoading = false;
          isUnSelectAvailable = false;
        });
      } else {
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              getUnSelectedSymptomsList
                  .add(GetUnSelectedChapterSymptomsModel.fromJson(map));
              getUnSelectedSymptomsList;
              debugPrint(getUnSelectedSymptomsList.length.toString());
              setState(() {
                getUnSelectedSymptomsList;
              });
              setState(() {
                isLoading = false;
              });
            }
          }
        }
      }
    }
  }

  List<GetSelectedChapterSymptomsModel> getSelectedSymptomsList = [];
  bool isSelectAvailable = true;

  Future getSelectedChapterSymptoms() async {
    getSelectedSymptomsList.clear();
    setState(() {
      isLoading = true;
      isSelectAvailable = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.getSelectedChapterSymptomsUrl}cat_id=${_chapterModel!.id}&user_id=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("getSelectedSymptoms Status Code: ${response.statusCode}");
      debugPrint(
          "getSelectedSymptoms Response Body: ${_chapterModel!.id}: ${response.body}");

      List values = [];
      values = jsonDecode(response.body);
      if (response.body.isEmpty || response.body == "[]") {
        setState(() {
          isLoading = false;
          isSelectAvailable = false;
        });
      } else {
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              getSelectedSymptomsList
                  .add(GetSelectedChapterSymptomsModel.fromJson(map));
              getSelectedSymptomsList;
              debugPrint(getSelectedSymptomsList.length.toString());
              setState(() {});
              setState(() {
                isLoading = false;
              });
            }
          }
        }
      }
    }
  }

  Future fetchDeleteSymp(index) async {
    Uri myUri = Uri.parse(
        "${NetworkUtil.fetchDeleteSelectSympUrl}user_id=${Constant.id}&symp_id=$index");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("fetchDeleteSymp Status Code: ${response.statusCode}");
      debugPrint("fetchDeleteSymp Response Body:   ${response.body}");
      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (map != null && map['message'] != null && map["success"] != null) {
        Fluttertoast.showToast(
            msg: Constant.language == '?lang=h'
                ? 'लक्षण अचयनित किया गया'
                : map['message']);

        if (response.statusCode == 200 &&
            map['message'] == "Symptom Unselected.") {
          setState(() {
            getUnSelectedChapterSymptoms();
            getSelectedChapterSymptoms();
          });

          Navigator.canPop(context);
        }
      }
    }
  }

  @override
  void initState() {
    dateFormat();
    super.initState();
  }

  Future<bool>? _onBackPressed() {
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, AppRoutes.ChapterPage);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_chapterModel == null) {
      setState(() {
        _chapterModel =
            ModalRoute.of(context)?.settings.arguments as ChapterModel?;
      });
      if (_chapterModel != null) {
        getIndication();
      }
    }
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return _onBackPressed()!;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constant.primaryColor,
            title: Text(_chapterModel!.chapter!),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Constant.secondaryColor,
              unselectedLabelColor: Constant.secondaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                    text: Constant.language == '?lang=h'
                        ? "अचयनित लक्षण"
                        : "UnSelect Symptoms"),
                Tab(
                    text: Constant.language == '?lang=h'
                        ? "चयनित लक्षण"
                        : "Selected Symptoms")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              isAvailable == false
                  ? Center(
                      child: buildText("के लिए कोई अचयनित लक्षण नहीं मिला",
                          "Not find any Unselect Symptoms for "))
                  : getUnSelectedTabSymptoms(),
              isAvailable == false
                  ? Center(
                      child: buildText("के लिए कोई चयनित लक्षण नहीं मिला",
                          "Not find any Selected Symptoms for "))
                  : getSelectedTabSymptoms(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildText(hindiText, engText) {
    return Text(
        Constant.language == '?lang=h'
            ? "${_chapterModel!.chapter!} $hindiText"
            : "$engText ${_chapterModel!.chapter!}",
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18));
  }

  String selectText(hindiT, engT) {
    return Constant.language == '?lang=h' ? hindiT : engT;
  }

  Widget getSelectedTabSymptoms() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isLoading == true)
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Container()),
                    CircleProgressIndicator.circleIndicator,
                    Expanded(child: Container()),
                  ],
                ))
          else if (getSelectedSymptomsList.isNotEmpty)
            ListView.builder(
                itemCount: getSelectedSymptomsList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  GetSelectedChapterSymptomsModel items =
                      getSelectedSymptomsList[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Card(
                      color: Constant.primaryColor,
                      shape: CardShape.shape,
                      shadowColor: Constant.primaryColor,
                      elevation: CardShape.elevation,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${index + 1}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(items.indication!,
                                    // maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                            GestureDetector(
                                onTap: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      headerAnimationLoop: false,
                                      animType: AnimType.bottomSlide,
                                      title: Constant.language == '?lang=h'
                                          ? "चेतावनी"
                                          : 'Warning',
                                      titleTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      desc: Constant.language == '?lang=h'
                                          ? "क्या आप निश्चित रूप से चुनिंदा लक्षण को हटाना चाहते हैं?"
                                          : 'Are you sure to remove selected symptom?',
                                      descTextStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      buttonsTextStyle:
                                          TextStyle(color: Colors.black),
                                      showCloseIcon: true,
                                      btnCancelOnPress: () {},
                                      btnOkText: selectText("हाँ", "OK"),
                                      btnCancelText:
                                          selectText("नहीं", "Cancel"),
                                      btnOkOnPress: () {
                                        setState(() {
                                          fetchDeleteSymp(items.id);
                                        });
                                      }).show();
                                },
                                child: Icon(Icons.delete,
                                    size: 20, color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                  );
                })
          else if (isSelectAvailable == false)
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: findText(
                          "इस अध्याय में किसी भी लक्षण का चयन नहीं किया गया है।",
                          "No symptoms are selected in this Chapter.")),
                  Expanded(child: Container()),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget getUnSelectedTabSymptoms() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isLoading == true)
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  CircleProgressIndicator.circleIndicator,
                  Expanded(child: Container()),
                ],
              ),
            )
          else if (getUnSelectedSymptomsList.isNotEmpty)
            ListView.builder(
              itemCount: getUnSelectedSymptomsList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                GetUnSelectedChapterSymptomsModel item =
                    getUnSelectedSymptomsList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Card(
                    color: Constant.primaryColor,
                    shape: CardShape.shape,
                    shadowColor: Constant.primaryColor,
                    elevation: CardShape.elevation,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              value: item.isCheck == true,
                              onChanged: (bool? value) {
                                setState(() {
                                  // isFetching == true
                                  //     ? SizedBox()
                                  //     : item.isCheck = value;
                                  // if (value == true) {
                                  //   isFetching == true
                                  //       ? SizedBox()
                                  //       : fetchSymptomRecorded(index);
                                  if (isFetching == false) {
                                    item.isCheck = value;
                                    fetchSymptomRecorded(index);
                                  }
                                  if (value == false) {
                                    Fluttertoast.showToast(
                                        msg: Constant.language == '?lang=h'
                                            ? 'लक्षण हटाया गया'
                                            : 'Symptom Removed');
                                  }
                                });
                              }),
                          Expanded(
                            child: Text(
                              item.indication!,
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          else if (isUnSelectAvailable == false)
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: findText(
                        "इस अध्याय में चुनने के लिए और कोई लक्षण नहीं है।",
                        "No more symptom to select in this chapter."),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget findText(hindiText, engText) {
    return Text(Constant.language == '?lang=h' ? hindiText : engText,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18));
  }

  List<IndicationModel> indicationList = [];

  Future getIndication() async {
    indicationList.clear();
    if (_chapterModel != null) {
      setState(() {
        isLoading = true;
        isAvailable = true;
      });
      Uri myUri = Uri.parse(
          "${NetworkUtil.getIndicationUrl}cat_id=${_chapterModel!.id}");
      Response response = await get(myUri);
      if (response.statusCode == 200) {
        debugPrint("getIndication Status Code: ${response.statusCode}");
        debugPrint("getIndication Response Body: ${response.body}");
        List values = [];
        values = jsonDecode(response.body);
        if (response.body == null || response.body == "[]") {
          setState(() {
            isAvailable = false;
            isLoading = false;
          });
        } else {
          if (values.isNotEmpty) {
            for (int i = 0; i < values.length; i++) {
              if (values[i] != null) {
                Map<String, dynamic> map = values[i];
                indicationList.add(IndicationModel.fromJson(map));
                setState(() {
                  indicationList;
                });
                setState(() {
                  isLoading = false;
                  // isAvailable = false;
                });
              }
            }
          }

          getUnSelectedChapterSymptoms();
          getSelectedChapterSymptoms();
        }
      }
    }
  }
}

// List<CheckBoxModel> checkBoxModelList = [];
// Future fetchCheckBoxDetails() async {
//   checkBoxModelList.clear();
//   Uri myUri = Uri.parse(
//       "https://mettlecrowsolutions.com/apps/apis/biochem_new/get-selected-symps.php?cat_id=${_chapterModel!.id}&user_id=${Constant.id}");
//   Response response = await get(myUri);
//   if (response.statusCode == 200) {
//     debugPrint("fetchCheckBoxDetails Status Code: ${response.statusCode}");
//     debugPrint("fetchCheckBoxDetails Response Body:} :: ${response.body}");
//     List<dynamic> values = <dynamic>[];
//     values = jsonDecode(response.body);
//     if (values.isNotEmpty) {
//       for (int i = 0; i < values.length; i++) {
//         if (values[i] != null) {
//           Map<String, dynamic> map = values[i];
//           checkBoxModelList.add(CheckBoxModel.fromJson(map));
//         }
//       }
//     }
//   }
// }

// SizedBox(
//   height: MediaQuery.of(context).size.height / 2.5,
//   width: MediaQuery.of(context).size.width,
//   child: getSelectedSymptomsList.isEmpty
//       ? SizedBox(
//           height: MediaQuery.of(context).size.height / 2.5,
//           width: MediaQuery.of(context).size.width,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: Container(),
//                 ),
//                 const CircularProgressIndicator(
//                   strokeWidth: 4,
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   "No Symptoms Selected",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 Expanded(
//                   child: Container(),
//                 ),
//               ],
//             ),
//           ),
//         )
//       : ListView.builder(
//           itemCount: getSelectedSymptomsList.length,
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     getSelectedSymptomsList[index].indication,
//                     style: const TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   // Expanded(child: Container()),
//                   GestureDetector(
//                     onTap: () {
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.WARNING,
//                         headerAnimationLoop: false,
//                         animType: AnimType.BOTTOMSLIDE,
//                         title: 'Warning',
//                         titleTextStyle: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                         desc:
//                             'Are you sure to remove select symptom?',
//                         descTextStyle: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600),
//                         buttonsTextStyle:
//                             const TextStyle(color: Colors.black),
//                         showCloseIcon: true,
//                         btnCancelOnPress: () {},
//                         btnOkOnPress: () {
//                           setState(() {
//                             fetchDeleteSymp(index);
//                           });
//                         },
//                       ).show();
//                     },
//                     child: const Icon(
//                       Icons.delete,
//                       size: 24,
//                       color: Colors.black,
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
// ),

// Expanded(
// child: getUnSelectedSymptomsList.isEmpty
// ? SizedBox(
// height: MediaQuery.of(context).size.height / 2.5,
// width: MediaQuery.of(context).size.width,
// child: const Center(
// child: CircularProgressIndicator(
// strokeWidth: 4,
// ),
// ),
// )
// : ListView.builder(
// itemCount: getUnSelectedSymptomsList.length,
// scrollDirection: Axis.vertical,
// shrinkWrap: true,
// itemBuilder: (context, index) {
// GetUnSelectedChapterSymptomsModel item =
// getUnSelectedSymptomsList[index];
// return Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 8, horizontal: 16),
// child: Column(
// children: [
// Card(
// color: Constant.primaryColor,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12)),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.start,
// children: [
// Checkbox(
// checkColor: Colors.white,
// value: item.isCheck == true,
// onChanged: (bool value) {
// setState(() {
// item.isCheck = value;
//
// if (value == true) {
// fetchSymptomRecorded(index);
// getSelectedChapterSymptoms();
// getUnSelectedChapterSymptoms();
// }
//
// if (value == false) {
// Fluttertoast.showToast(
// msg: 'Symptom Removed');
// }
// });
// }),
// Text(
// item.indication,
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 18),
// ),
// ],
// ),
// ],
// ),
// ),
// ],
// ),
// );
// },
// ),
// ),

//fetch fetchSymptomRecorded

// Future fetchSymptomRecorded(int index) async {
//   final body = {"success": true, "message": "Symptom Recorded"};
//
//   var myUri = Uri.parse(
//       "https://mettlecrowsolutions.com/apps/apis/biochem_new/save-symptom.php?device_id=$deviceValue&indi_id=${indicationList[index].id}&rem_id=${indicationList[index].rem_id}&cat_id=${_chapterModel.id}&created_on=$dateValue");
//
//   final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
//   final jsonString = jsonEncode(body);
//
//   var response = await http.post(myUri, headers: headers, body: jsonString);
//
//   debugPrint("fetchSymptomRecorded Status Code: ${response.statusCode}");
//   debugPrint("fetchSymptomRecorded Response Body: ${response.body}");
//
//   Map<String, dynamic> map =
//       jsonDecode(response.body) as Map<String, dynamic>;
//   if (map != null && map['message'] != null) {
//     Fluttertoast.showToast(msg: map['message']);
//
//     if (response.statusCode == 200 && map['message'] == "Symptom Recorded") {
//       Navigator.canPop(context);
//     }
//   }
// }
