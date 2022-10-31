// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/model/medicine_page/medicine_name_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../model/medicine_page/remedies_ind_model.dart';

class MedicineDetailsPage extends StatefulWidget {
  const MedicineDetailsPage({Key? key}) : super(key: key);

  @override
  State<MedicineDetailsPage> createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  MedicineNameModel? _medicineNameModel;
  bool isLoading = false;

  List<GetRemediesIndModel> getMedRemediesIndModelList = [];

  Future getMedRemediesInd() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.getRemediesIndUrl}rem_id=${_medicineNameModel!.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("getMedRemediesInd Status Code: ${response.statusCode}");
      debugPrint("getMedRemediesInd Response Body: ${response.body}");
      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            getMedRemediesIndModelList.add(GetRemediesIndModel.fromJson(map));

            getMedRemediesIndModelList;
          }
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

  @override
  Widget build(BuildContext context) {
    if (_medicineNameModel == null) {
      _medicineNameModel =
          ModalRoute.of(context)?.settings.arguments as MedicineNameModel?;
      getMedRemediesInd();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_medicineNameModel!.remName!),
        centerTitle: true,
        backgroundColor: Constant.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 10, 4),
              child: Row(
                children: [
                  getMedRemediesIndModelList.isNotEmpty
                      ? Text(
                          Constant.language == '?lang=h'
                              ? "संकेत"
                              : "Indications",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                      : SizedBox(),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  children: [
                    if (isLoading == true)
                      Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3),
                              CircleProgressIndicator.circleIndicator,
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3)
                            ],
                          ))
                    else if (getMedRemediesIndModelList.isNotEmpty)
                      Card(
                        shadowColor: Constant.primaryColor,
                        shape: CardShape.shape,
                        elevation: CardShape.elevation,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: getMedRemediesIndModelList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            bulletContainer(),
                                            const SizedBox(width: 10)
                                          ],
                                        ),
                                        Expanded(
                                            child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      "${getMedRemediesIndModelList[index].categoryName} : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          getMedRemediesIndModelList[
                                                                  index]
                                                              .indication,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.normal),
                                                    )
                                                  ],
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true))
                                      ],
                                    ));
                              },
                            )),
                      )
                    else
                      Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3),
                              Text(
                                  Constant.language == '?lang=h'
                                      ? "${_medicineNameModel!.remName!} के लिए \nकोई संकेत नहीं मिला"
                                      : "${_medicineNameModel!.remName!}'s\n No indication found.",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5)
                            ],
                          ))
                  ],
                )),
          ],
        )),
      ),
    );
  }

  Widget bulletContainer() {
    return Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle));
  }
}

// ListView.builder(
//   shrinkWrap: true,
//   itemCount:
//       indicationList.length,
//   physics:
//       const NeverScrollableScrollPhysics(),
//   itemBuilder:
//       (context, index) {
//     // Details details = item.details[index];
//     return Padding(
//       padding:
//           const EdgeInsets
//                   .symmetric(
//               horizontal:
//                   26,
//               vertical: 2),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets
//                     .symmetric(
//                 vertical:
//                     6),
//             child: Row(
//               children: [
//                 // bulletContainer(),
//                 const SizedBox(
//                     width:
//                         20),
//                 Expanded(
//                   child:
//                       Text(
//                     indicationList[index]
//                         .indication,
//                     style: const TextStyle(
//                         fontSize:
//                             18),
//                     maxLines:
//                         2,
//                     softWrap:
//                         true,
//                     overflow:
//                         TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   },
// ),
