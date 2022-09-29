import 'dart:convert';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/model/about_page_model/about_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<AboutModel> aboutModelList = [];
  bool isLoading = false;

  Future getAboutContent() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(NetworkUtil.getAboutContentUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("getAboutContent Status Code: ${response.statusCode}");
      debugPrint("getAboutContent Response Body: ${response.body}");
      List values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            aboutModelList.add(AboutModel.fromJson(map));
            aboutModelList;
            setState(() {});
            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }
  }

  @override
  void initState() {
    getAboutContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
        backgroundColor: Constant.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              isLoading
                  ? Center(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5),
                        const CircularProgressIndicator(strokeWidth: 4),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: aboutModelList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            child: Card(
                              color: Constant.primaryColor,
                              shape: CardShape.shape,
                              elevation: CardShape.elevation,
                              shadowColor: Constant.primaryColor,
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(fontSize: 20,color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          aboutModelList[index].content!,
                                          maxLines: 5,
                                          style: const TextStyle(
                                              color: Constant.secondaryColor,                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
