import 'dart:convert';

import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/model/medicine_page/medicine_name_model.dart';
import 'package:biochemic_master/model/medicine_page/remedies_ind_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({Key? key}) : super(key: key);

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  bool isLoading = false;

  List<MedicineNameModel> medicineNameModelList = [];

  Future fetchMedicineName() async {
    getRemediesInd();
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(NetworkUtil.fetchMedicineNameUrlCh+ Constant.language!);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("fetchMedicineName Status Code: ${response.statusCode}");
      debugPrint("fetchMedicineName Response Body: ${response.body}");

      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            medicineNameModelList.add(MedicineNameModel.fromJson(map));

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

  List<GetRemediesIndModel> getRemediesIndModelList = [];

  Future getRemediesInd() async {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < medicineNameModelList.length; i++) {
      Uri myUri = Uri.parse("${NetworkUtil.getRemediesIndUrl}rem_id=${i + 1}");
      Response response = await get(myUri);
      if (response.statusCode == 200) {
        debugPrint("getRemediesInd Status Code: ${response.statusCode}");
        debugPrint("getRemediesInd Response Body::  ${response.body}");
        List values = [];
        values = jsonDecode(response.body);
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              getRemediesIndModelList.add(GetRemediesIndModel.fromJson(map));
              getRemediesIndModelList;
              setState(() {
                isLoading = false;
              });
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    fetchMedicineName();

    super.initState();
  }

  String? titleText;

  @override
  Widget build(BuildContext context) {
    titleText = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        centerTitle: true,
        title: Text(titleText.toString().trim()),
        // title: const Text("Remedies"),
      ),
      body: SingleChildScrollView(
        child: (isLoading)
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 3),
                    CircleProgressIndicator.circleIndicator,
                    SizedBox(height: MediaQuery.of(context).size.height / 2),
                  ],
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medicineNameModelList.length,
                  itemBuilder: (context, index) {
                    // getRemediesInd(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        height: ConHeight.height,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.MedicineDetailsPage,
                                arguments: medicineNameModelList[index]);
                          },
                          child: Card(
                            shadowColor: Constant.primaryColor,
                            color: Constant.primaryColor,
                            shape: CardShape.shape,
                            elevation: CardShape.elevation,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Constant.primaryColor,
                                    backgroundImage: Images.logoImg,
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    medicineNameModelList[index].remName!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Constant.secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

// import 'dart:convert';
//
// import 'package:biochemic_master/Shared/constant.dart';
// import 'package:biochemic_master/Shared/routes.dart';
// import 'package:biochemic_master/model/medicine_page/medicine_name_model.dart';
// import 'package:biochemic_master/model/medicine_page/remedies_ind_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class MedicinePage extends StatefulWidget {
//   const MedicinePage({Key key}) : super(key: key);
//
//   @override
//   State<MedicinePage> createState() => _MedicinePageState();
// }
//
// class _MedicinePageState extends State<MedicinePage> {
//   bool isLoading = false;
//
//   List<MedicineNameModel> medicineNameModelList = [];
//
//   Future fetchMedicineName() async {
//     setState(() {
//       isLoading = true;
//     });
//     Uri myUri = Uri.parse(NetworkUtil.fetchMedicineNameUrl);
//     Response response = await get(myUri);
//     if (response.statusCode == 200) {
//       debugPrint("fetchMedicineName Status Code: ${response.statusCode}");
//       debugPrint("fetchMedicineName Response Body: ${response.body}");
//
//       List values = [];
//       values = jsonDecode(response.body);
//       if (values.isNotEmpty) {
//         for (int i = 0; i < values.length; i++) {
//           if (values[i] != null) {
//             Map<String, dynamic> map = values[i];
//             medicineNameModelList.add(MedicineNameModel.fromJson(map));
//             medicineNameModelList;
//             setState(() {
//               isLoading = false;
//             });
//           }
//         }
//       }
//     }
//   }
//
//   List<GetRemediesIndModel> getRemediesIndModelList = [];
//
//   Future getRemediesInd() async {
//     for (int i = 1; i <= medicineNameModelList.length; i++) {
//       Uri myUri = Uri.parse("${NetworkUtil.getRemediesIndUrl}rem_id=$i");
//       Response response = await get(myUri);
//       if (response.statusCode == 200) {
//         debugPrint("getRemediesInd Status Code: ${response.statusCode}");
//         debugPrint("getRemediesInd Response Body:  ${response.body}");
//         List values = [];
//         values = jsonDecode(response.body);
//         if (values.isNotEmpty) {
//           for (int i = 0; i < values.length; i++) {
//             if (values[i] != null) {
//               Map<String, dynamic> map = values[i];
//               getRemediesIndModelList.add(GetRemediesIndModel.fromJson(map));
//               getRemediesIndModelList;
//               setState(() {});
//             }
//           }
//         }
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     fetchMedicineName();
//     getRemediesInd();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Constant.primaryColor,
//         centerTitle: true,
//         title: const Text("Remedies"),
//       ),
//       body: SingleChildScrollView(
//         child: (isLoading)
//             ? Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height / 3),
//                     const CircularProgressIndicator(strokeWidth: 4),
//                     SizedBox(height: MediaQuery.of(context).size.height / 2),
//                   ],
//                 ),
//               )
//             : Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: medicineNameModelList.length,
//                   itemBuilder: (context, index) {
//                     GetRemediesIndModel item = getRemediesIndModelList[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14)),
//                         height: ConHeight.height,
//                         width: MediaQuery.of(context).size.width,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, AppRoutes.DetailsPage,
//                                 arguments: item);
//                           },
//                           child: Card(
//                             shadowColor: Constant.primaryColor,
//                             color: Constant.primaryColor,
//                             shape: CardShape.shape,
//                             elevation: CardShape.elevation,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   const CircleAvatar(
//                                     backgroundColor: Constant.primaryColor,
//                                     backgroundImage: Images.logoImg,
//                                     radius: 20,
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Text(
//                                     medicineNameModelList[index].remName,
//                                     style: const TextStyle(
//                                         fontSize: 20,
//                                         color: Constant.secondaryColor),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     getRemediesInd();
//     super.dispose();
//   }
// }
