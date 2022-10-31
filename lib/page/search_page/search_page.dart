// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:convert';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../model/search/search_ind_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  List<SearchIndModel> getSearchIndModelList = [];

  Future getSearchInd(String value) async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse("${NetworkUtil.searchRemediesUrl}indication=$value");
    Response response = await get(myUri);
    getSearchIndModelList.clear();
    if (response.statusCode == 200) {
      debugPrint("getSearchInd Status Code: ${response.statusCode}");
      debugPrint("getSearchInd Response Body: ${response.body}");
      List values = [];
      getSearchIndModelList.clear();
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            getSearchIndModelList.add(SearchIndModel.fromJson(map));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  String? titleText;

  @override
  Widget build(BuildContext context) {
    titleText = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        centerTitle: true,
        // title: const Text("Search Your Symptom"),
        title: Text(titleText.toString().trim()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shadowColor: Constant.primaryColor,
              shape: CardShape.shape,
              elevation: CardShape.elevation,
              child: TextField(
                  controller: searchController,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    focusColor: Constant.primaryColor,
                    // iconColor: Constant.primaryColor,
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(width: 2, color: Colors.green)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(width: 2, color: Colors.green)),
                    suffixStyle: const TextStyle(color: Constant.primaryColor),
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Constant.primaryColor),
                        borderRadius: BorderRadius.circular(14)),
                    hintText: Constant.language == '?lang=h'
                        ? "लिखे  fever, pain जैसे"
                        : "Type fever, pain etc",
                    // suffixIconColor: Constant.primaryColor,
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (searchController.text.isNotEmpty) {
                        searchController.text.characters.first.contains(" ")
                            ? searchController.clear()
                            : value.trim().isEmpty
                                ? null
                                : getSearchInd(value.trim());
                      }
                    });
                  }),
            ),
            SizedBox(height: 8),
            searchController.text.trim().isEmpty
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 0, 4),
                    child: Text(
                      Constant.language == '?lang=h'
                          ? "अनुशंसित उपचार"
                          : "Recommended Remedies:",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
            SizedBox(height: 8),
            Expanded(
              child: Column(
                children: [
                  if (searchController.text.trim().isEmpty)
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 5),
                          Text(
                            Constant.language == '?lang=h'
                                ? "कृपया अपने लक्षण खोजें"
                                : "Please Search Your Symptoms",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  else if (isLoading == true &&
                      searchController.text.isNotEmpty)
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 6),
                          CircleProgressIndicator.circleIndicator,
                          SizedBox(height: 12),
                          Text(
                              Constant.language == '?lang=h'
                                  ? "कृपया प्रतीक्षा करें"
                                  : "Please Wait",
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    )
                  else if (getSearchIndModelList.isNotEmpty &&
                      isLoading == false)
                    Expanded(
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: getSearchIndModelList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.DetailsPage,
                                    arguments: getSearchIndModelList[index]);
                              },
                              child: buildCard(index),
                            ));
                      },
                    ))
                  else
                    (getSearchIndModelList.isEmpty &&
                            getSearchIndModelList == null)
                        ? Text("")
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                              child: Text(
                                  Constant.language == '?lang=h'
                                      ? "इस नाम के लिए कोई परिणाम नहीं मिला: ${searchController.text.trim()}"
                                      : 'No result found for this name: ${searchController.text.trim()}',
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis)),
                            ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    return Card(
      shadowColor: Constant.primaryColor,
      color: Constant.primaryColor,
      shape: CardShape.shape,
      elevation: CardShape.elevation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Images.logoImg,
              radius: 16,
            ),
            const SizedBox(width: 12),
            Text(getSearchIndModelList[index].remName!,
                style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}

// results = itemCardList
//     .where((user) => user.articles[0].name1.toString()
//         .toLowerCase()
//         .contains(searchKey.toLowerCase()))
//     .toList();

// void _runFilter(String searchKey) {
//   List<SearchIndModel> results = [];
//   results.clear();
//   if (searchKey.isEmpty ||
//       (searchController.text.isEmpty && searchController.text.contains(""))) {
//     results = _foundUser;
//   } else {
//     results = getSearchIndModelList
//         .where((user) =>
//             user.remName.toLowerCase().contains(searchKey.toLowerCase()))
//         .cast<SearchIndModel>()
//         .toList();
//     setState(() {
//       _foundUser = results;
//     });
//   }
//   setState(() {
//     _foundUser = results;
//   });
// }
