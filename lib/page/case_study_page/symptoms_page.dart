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
  int index = 1;
  var checkId =
      (Constant.id != '' || Constant.id == null || Constant.id.isEmpty);

  List<IndicationModel> indicationList = [];

  Future getIndication() async {
    indicationList.clear();
    if (_chapterModel != null) {
      setState(() {
        isLoading = true;
      });
      Uri myUri = Uri.parse(
          "${NetworkUtil.getIndicationUrl}cat_id=${_chapterModel!.id}");
      Response response = await get(myUri);
      if (response.statusCode == 200) {
        debugPrint("getIndication Status Code: ${response.statusCode}");
        debugPrint("getIndication Response Body: ${response.body}");
        List values = [];
        values = jsonDecode(response.body);
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
              });
            }
          }
        }
      }
      getUnSelectedChapterSymptoms();
      getSelectedChapterSymptoms();
    }
  }

  Future fetchSymptomRecorded(int index) async {
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

        Fluttertoast.showToast(msg: map['message']);

        if (response.statusCode == 200 &&
            map['message'] == "Symptom Recorded") {
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

  List<CheckBoxModel> checkBoxModelList = [];

  Future fetchCheckBoxDetails() async {
    checkBoxModelList.clear();
    Uri myUri = Uri.parse(
        "https://mettlecrowsolutions.com/apps/apis/biochem_new/get-selected-symps.php?cat_id=${_chapterModel!.id}&user_id=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("fetchCheckBoxDetails Status Code: ${response.statusCode}");
      debugPrint("fetchCheckBoxDetails Response Body:} :: ${response.body}");
      List<dynamic> values = <dynamic>[];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            checkBoxModelList.add(CheckBoxModel.fromJson(map));
          }
        }
      }
    }
  }

  List<GetUnSelectedChapterSymptomsModel> getUnSelectedSymptomsList = [];

  Future getUnSelectedChapterSymptoms() async {
    getUnSelectedSymptomsList.clear();
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.getUnSelectedChapterSymptomsUrl}cat_id=${_chapterModel!.id}&user_id=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("getUnSelectedSymptoms Status Code: ${response.statusCode}");
      debugPrint("getUnSelectedSymptoms Response Body: ${response.body}");

      List values = [];
      values = jsonDecode(response.body);
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

  List<GetSelectedChapterSymptomsModel> getSelectedSymptomsList = [];

  Future getSelectedChapterSymptoms() async {
    getSelectedSymptomsList.clear();
    setState(() {
      isLoading = true;
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
        Fluttertoast.showToast(msg: map['message']);

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
      _chapterModel = ModalRoute.of(context)?.settings.arguments as ChapterModel?;
      getIndication();
    }
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: (){
          return _onBackPressed()!;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constant.primaryColor,
            title: Text(_chapterModel!.chapter!),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Constant.secondaryColor,
              unselectedLabelColor: Constant.secondaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "UnSelect Symptoms"),
                Tab(text: "Selected Symptoms")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              getUnSelectedTabSymptoms(),
              getSelectedTabSymptoms(),
            ],
          ),
        ),
      ),
    );
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
                  Expanded(
                    child: Container(),
                  ),
                  const CircularProgressIndicator(strokeWidth: 4),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            )
          else if (getSelectedSymptomsList.isNotEmpty)
            ListView.builder(
                itemCount: getSelectedSymptomsList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  GetSelectedChapterSymptomsModel items =
                      getSelectedSymptomsList[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Card(
                      color: Constant.primaryColor,
                      shape: CardShape.shape,
                      shadowColor: Constant.primaryColor,
                      elevation: CardShape.elevation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${index + 1}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(items.indication!,
                                    // maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                            GestureDetector(
                                onTap: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.WARNING,
                                      headerAnimationLoop: false,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Warning',
                                      titleTextStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      desc:
                                          'Are you sure to remove select symptom?',
                                      descTextStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      buttonsTextStyle:
                                          const TextStyle(color: Colors.black),
                                      showCloseIcon: true,
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        if (
                                            Constant.id == null ||
                                            Constant.id.isEmpty||
                                                Constant.id =='') {
                                          Fluttertoast.showToast(
                                              msg: "Please Login First");
                                          Navigator.pushReplacementNamed(
                                              context, AppRoutes.LoginPage);
                                        } else {
                                          setState(() {
                                            fetchDeleteSymp(items.id);
                                          });
                                        }
                                      }).show();
                                },
                                child: const Icon(Icons.delete,
                                    size: 20, color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                  );
                })
          else
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  const Text("No symptoms are selected in this Chapter.",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
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
                  const CircularProgressIndicator(strokeWidth: 4),
                  Expanded(child: Container()),
                ],
              ),
            )
          else if (getUnSelectedSymptomsList.isNotEmpty)
            ListView.builder(
              itemCount: getUnSelectedSymptomsList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                GetUnSelectedChapterSymptomsModel item =
                    getUnSelectedSymptomsList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Card(
                    color: Constant.primaryColor,
                    shape: CardShape.shape,
                    shadowColor: Constant.primaryColor,
                    elevation: CardShape.elevation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              value: item.isCheck == true,
                              onChanged: (bool? value) {
                                setState(() {
                                  item.isCheck = value;
                                  if (value == true) {
                                    if (Constant.id == null ||
                                        Constant.id.isEmpty||
                                        Constant.id =='') {
                                      Fluttertoast.showToast(
                                          msg: "Please Login First");
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.LoginPage);
                                    } else {
                                      fetchSymptomRecorded(index);
                                    }
                                  }
                                  if (value == false) {
                                    Fluttertoast.showToast(
                                        msg: 'Symptom Removed');
                                  }
                                });
                              }),
                          Expanded(
                            child: Text(
                              item.indication!,
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          else
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  const Text("No more symptom to select in this chapter.",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

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
