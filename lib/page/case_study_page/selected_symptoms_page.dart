// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biochemic_master/model/caseModel/selected_symp_page/selected_symptoms_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SelectedSymptomsPage extends StatefulWidget {
  const SelectedSymptomsPage({Key? key}) : super(key: key);

  @override
  State<SelectedSymptomsPage> createState() => _SelectedSymptomsPageState();
}

class _SelectedSymptomsPageState extends State<SelectedSymptomsPage> {
  bool isLoading = false;
  List<SelectedSymptomsModel> selectedSymptomsModelList = [];

  Future fetchTotalSelectedChapterSymptoms() async {
    selectedSymptomsModelList.clear();
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.fetchTotalSelectedChapterSymptomsUrl}user_id=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint(
          "fetchTotalSelectedChapterSymptoms Status Code: ${response.statusCode}");
      debugPrint(
          "fetchTotalSelectedChapterSymptoms Response Body: ${response.body}");

      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            selectedSymptomsModelList.add(SelectedSymptomsModel.fromJson(map));
            if (mounted) {
              setState(() {
                isLoading = false;
                if(selectedSymptomsModelList.isEmpty){
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, AppRoutes.ChapterPage);
                }
              });
            } else {
              isLoading = false;
            }
          }
        }
      }
    }
  }

  Future fetchDeleteSymp(index) async {
    Uri myUri = Uri.parse(
        "${NetworkUtil.fetchDeleteSelectSympUrl}user_id=${Constant.id}&symp_id=${selectedSymptomsModelList[index].indiId}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("fetchDeleteSymp Status Code: ${response.statusCode}");
      debugPrint("fetchDeleteSymp Response Body: $index ::   ${response.body}");

      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (map != null && map['message'] != null && map["success"] != null) {
        Fluttertoast.showToast(
            msg: Constant.language == "?lang=h"
                ? "लक्षण अचयनित किया गया"
                : map['message']);

        if (response.statusCode == 200 &&
            map['message'] == "Symptom Unselected.") {
          setState(() {
            fetchTotalSelectedChapterSymptoms();
            if(selectedSymptomsModelList.isEmpty){
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, AppRoutes.ChapterPage);
            }
          });
          Navigator.canPop(context);
        }
      }
    }
  }

  Future<bool>? _onBackPressed() {
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, AppRoutes.ChapterPage);
    return null;
  }

  @override
  void initState() {
    fetchTotalSelectedChapterSymptoms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return _onBackPressed()!;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(Constant.language == "?lang=h"
                ? "चुने हुए लक्षण"
                : "Selected Symptoms"),
            centerTitle: true,
            backgroundColor: Constant.primaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: (isLoading == true)
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 2),
                              CircleProgressIndicator.circleIndicator,
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 2),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: selectedSymptomsModelList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          SelectedSymptomsModel item =
                              selectedSymptomsModelList[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                            child: Card(
                              color: Constant.primaryColor,
                              shadowColor: Constant.primaryColor,
                              elevation: CardShape.elevation,
                              shape: CardShape.shape,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.categoryName}, ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              88,
                                          child: Text(
                                            item.indication!,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.remName!,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.warning,
                                              headerAnimationLoop: false,
                                              animType: AnimType.bottomSlide,
                                              title:
                                                  Constant.language == '?lang=h'
                                                      ? "चेतावनी"
                                                      : 'Warning',
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              desc: Constant.language ==
                                                      '?lang=h'
                                                  ? "क्या आप निश्चित रूप से चुनिंदा लक्षण को हटाना चाहते हैं?"
                                                  : 'Are you sure to remove select symptom?',
                                              descTextStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              buttonsTextStyle: const TextStyle(
                                                  color: Colors.black),
                                              showCloseIcon: true,
                                              btnCancelOnPress: () {},
                                              btnOkText:
                                                  Constant.language == '?lang=h'
                                                      ? "हाँ"
                                                      : "OK",
                                              btnCancelText:
                                                  Constant.language == '?lang=h'
                                                      ? "नहीं"
                                                      : "Cancel",
                                              btnOkOnPress: () {
                                                setState(() {
                                                  fetchDeleteSymp(index);
                                                 if(selectedSymptomsModelList.isEmpty){
                                                   Navigator.of(context).pop();
                                                   Navigator.pushReplacementNamed(context, AppRoutes.ChapterPage);
                                                 }
                                                });
                                              },
                                            ).show();
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            size: 24,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )),
              (isLoading == true || selectedSymptomsModelList.isEmpty)
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Constant.primaryColor,
                        shadowColor: Constant.primaryColor,
                        shape: CardShape.shape,
                        elevation: CardShape.elevation,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 3.8,
                              vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  (Navigator.pushNamed(
                                      context, AppRoutes.RepertorisePage));
                                },
                                child: Text(
                                  Constant.language == "?lang=h"
                                      ? "रेपोट्राइज़"
                                      : "Repertorise",
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
