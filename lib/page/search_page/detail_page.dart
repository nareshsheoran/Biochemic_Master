// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ui';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/model/search/search_ind_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../model/medicine_page/remedies_ind_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // GetRemediesIndModel _getRemediesIndModel;
  SearchIndModel? _searchIndModel;

  bool isLoading = false;

  List<GetRemediesIndModel> getRemediesIndModelList = [];

  Future getRemediesInd() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.getRemediesIndUrl}rem_id=${_searchIndModel!.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("getRemediesInd Status Code: ${response.statusCode}");
      debugPrint("getRemediesInd Response Body: ${response.body}");
      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            getRemediesIndModelList.add(GetRemediesIndModel.fromJson(map));
            setState(() {
              getRemediesIndModelList;
            });
            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_searchIndModel == null) {
      _searchIndModel =
          ModalRoute.of(context)?.settings.arguments as SearchIndModel?;
      getRemediesInd();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text(_searchIndModel!.remName!),
          centerTitle: true,
          backgroundColor: Constant.primaryColor),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18, 8, 10, 4),
                child: Row(
                  children: [
                    Text(
                        Constant.language == '?lang=h'
                            ? "संकेत"
                            : "Indications",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  children: [
                    if (isLoading == true)
                      Padding(
                          padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 3),
                              CircleProgressIndicator.circleIndicator,
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 2.5)
                            ],
                          ))
                    else if (getRemediesIndModelList.isNotEmpty)
                      Card(
                        shadowColor: Constant.primaryColor,
                        shape: CardShape.shape,
                        elevation: CardShape.elevation,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getRemediesIndModelList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      SizedBox(width: 10),
                                      bulletContainer(),
                                      SizedBox(width: 10)
                                    ]),
                                    Expanded(
                                        child: RichText(
                                            text: TextSpan(
                                                text:
                                                    "${getRemediesIndModelList[index].categoryName}: ",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                    fontStyle:
                                                        FontStyle.italic),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          getRemediesIndModelList[
                                                                  index]
                                                              .indication,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.normal))
                                                ]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.width / 3),
                            Text(
                                Constant.language == '?lang=h'
                                    ? "कोई संकेत नहीं मिला"
                                    : "No indication found.",
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            SizedBox(
                                height: MediaQuery.of(context).size.width / 2.5)
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
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

//
//
// import 'package:biochemic_master/Shared/constant.dart';
// import 'package:flutter/material.dart';
// import '../../model/search/search_ind_model.dart';
//
// class DetailsPage extends StatefulWidget {
//   const DetailsPage({Key key}) : super(key: key);
//
//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//   SearchIndModel _searchIndModel;
//
//   @override
//   Widget build(BuildContext context) {
//     _searchIndModel ??= ModalRoute.of(context).settings.arguments;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text(_searchIndModel.remName),
//         centerTitle: true,
//         backgroundColor: Constant.primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(18, 8, 10, 4),
//               child: Row(
//                 children: const [
//                   Text("Indications",
//                       style:
//                       TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                 child: Column(
//                   children: [
//                     if (_searchIndModel.remName.isEmpty)
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                   height:
//                                   MediaQuery.of(context).size.width / 3),
//                               const CircularProgressIndicator(strokeWidth: 4),
//                               SizedBox(
//                                   height:
//                                   MediaQuery.of(context).size.width / 2.5),
//                             ],
//                           ),
//                         ),
//                       )
//                     else if (_searchIndModel.id.isNotEmpty)
//                       Card(
//                         shadowColor: Constant.primaryColor,
//                         shape: CardShape.shape,
//                         elevation: CardShape.elevation,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           // mainAxisAlignment: MainAxisAlignment.c,
//                           children: [
//                             const SizedBox(width: 10),
//                             bulletContainer(),
//                             const SizedBox(width: 10),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 12),
//                               child: Text(
//                                 _searchIndModel.remName,
//                                 style: const TextStyle(
//                                     fontStyle: FontStyle.italic,
//                                     color: Constant.primaryColor,
//                                     fontSize: 18),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     else
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                                 height: MediaQuery.of(context).size.width / 3),
//                             const Text("No indication found.",
//                                 maxLines: 3,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.w600)),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.width / 2.5,
//                             ),
//                           ],
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget bulletContainer() {
//     return Container(
//       height: 8,
//       width: 8,
//       decoration: const BoxDecoration(
//           color: Constant.primaryColor, shape: BoxShape.circle),
//     );
//   }
// }
