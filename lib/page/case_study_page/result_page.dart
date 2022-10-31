// ignore_for_file: prefer_const_literals_to_create_immutables,, unnecessary_string_interpolations
// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:core';
import 'package:biochemic_master/model/repertories_page_model/getResultModel.dart';
import 'package:biochemic_master/model/result_page_model/getRecordSympDetails_Model.dart';
import 'package:http/http.dart' as http;
import 'package:biochemic_master/Shared/constant.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  GetResultModel? _getResultModel;
  String? title;

  bool isLoading = false;

  List<RecordRemCountDetailsModel> getResultRemCountDetailsModelList = [];

  Future getRemSympDetailsCount() async {
    // getResultModelList.clear();
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.get(Uri.parse(
        "${NetworkUtil.fetchRecordRemSympDetailsUrl}user_id=${Constant.id}&rem_name=${_getResultModel!.rem!.split('-')[0]}"));

    if (response.statusCode == 200) {
      debugPrint("getRemSympDetailsCount Status Code: ${response.statusCode}");
      debugPrint("getRemSympDetailsCount Response Body: ${response.body}");

      List<dynamic> values = <dynamic>[];
      values = jsonDecode(response.body);
      if (response.body == null || response.body == "[]") {
        setState(() {
          isLoading = false;
        });
      } else {
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              getResultRemCountDetailsModelList
                  .add(RecordRemCountDetailsModel.fromJson(map));
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              } else {
                isLoading = false;
              }
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_getResultModel == null) {
      _getResultModel =
          ModalRoute.of(context)?.settings.arguments as GetResultModel?;
      getRemSympDetailsCount();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_getResultModel!.rem!.split('-')[0]),
        centerTitle: true,
        backgroundColor: Constant.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                Constant.language == '?lang=h'
                    ? "लक्षण कवर: ${_getResultModel!.rem!.split(',')[0].split("-")[1]}"
                    : "Symptoms Covered: ${_getResultModel!.rem!.split(',')[0].split("-")[1]}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: (isLoading)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: CircleProgressIndicator.circleIndicator))
                    : ListView.builder(
                        // itemCount: nameList.length,
                        itemCount: getResultRemCountDetailsModelList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          RecordRemCountDetailsModel item =
                              getResultRemCountDetailsModelList[index];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(2, 8, 2, 8),
                            child: Card(
                              color: Constant.primaryColor,
                              shape: CardShape.shape,
                              shadowColor: Constant.primaryColor,
                              elevation: CardShape.elevation,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${item.categoryName}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text("${item.indication}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
