import 'dart:convert';
import 'dart:ui';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:http/http.dart';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/myCases_model.dart';

class MyCases extends StatefulWidget {
  const MyCases({Key? key}) : super(key: key);

  @override
  State<MyCases> createState() => _MyCasesState();
}

class _MyCasesState extends State<MyCases> {
  var dateValue = '';

  Future dateFormat() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    dateValue = formattedDate;
    debugPrint("DateFormat: $dateValue");
  }

  bool isLoading = false;
  List<MyCasesModel> myCasesModelList = [];

  Future fetchMyCases() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse("${NetworkUtil.getMyCasesUrl}userid=${Constant.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("fetchMyCases Status Code: ${response.statusCode}");
      debugPrint("fetchMyCases Response Body: ${response.body}");
      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            myCasesModelList.add(MyCasesModel.fromJson(map));
            myCasesModelList;
            setState(() {});
            setState(() {
              isLoading = false;
            });
          }
        }
      }

      LocalDataSaver.saveID(myCasesModelList[0].userId);

      Constant.id = (await LocalDataSaver.getID())!;
    }
    // }
  }

  @override
  void initState() {
    fetchMyCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: const Text("My Cases"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              (isLoading)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: myCasesModelList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime now =
                            DateTime.parse(myCasesModelList[index].date!);
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(now);
                        dateValue = formattedDate;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          child: Card(
                            elevation: CardShape.elevation,
                            color: Constant.primaryColor,
                            shadowColor: Constant.primaryColor,
                            shape: CardShape.shape,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Case: ${myCasesModelList[index].id}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        dateValue,
                                        // myCasesModelList[index].date.toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 10,
                                        child: Text(
                                            myCasesModelList[index].userId!),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Symps",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
