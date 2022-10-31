// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/model/front_page_req.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:biochemic_master/service/device_id_service.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool isLogin = false;

  getLoggedInState() async {
    await LocalDataSaver.getLogData().then((value) {
      setState(() {
        isLogin = value!;
      });
    });
  }

  Future fetchValue() {
    return DeviceIdService().getDeviceId();
  }

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        _deviceData = deviceData;
      }
    } catch (e) {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version. $e'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.codename': build.version.codename,
      'device': build.device,
      'id': build.id,
      'brand': build.brand,
    };
  }

  StreamSubscription? subscription;
  bool isNetConnected = true;
  bool isLoading = false;

  void init() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        isNetConnected = true;
      } else {
        isNetConnected = false;
      }
    });
  }

  void getData() async {
    Constant.language = (await LocalDataSaver.getLanguage());
  }

  Future logout() async {
    setState(() {
      LocalDataSaver.saveLoginData(false);
      isLogin == false;
      LocalDataSaver.saveID(null);
      LocalDataSaver.saveID('');
      Constant.id == null;
      Constant.id == '';
      Constant.id = '';
      Fluttertoast.showToast(
          msg: Constant.language == '?lang=h'
              ? "सफलतापूर्वक लॉग आउट"
              : "Logout Successfully");
      Navigator.pushReplacementNamed(context, AppRoutes.FrontPage);
    });
    // Navigator.of(context).pop();

    // Navigator.pop(context);
  }

  List<FrontPageReq> aboutModelList = [];

  Future getAboutContent() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri =
        Uri.parse(NetworkUtil.fetchFrontPageLinkUrlCh + Constant.language!);
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
            aboutModelList.add(FrontPageReq.fromJson(map));
            aboutModelList;
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
  void initState() {
    super.initState();
    initPlatformState();
    getLoggedInState();
    fetchValue();
    getAboutContent();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          isLoading
              ? SizedBox()
              : Positioned(
                  right: 20,
                  top: 38,
                  child: PopupMenuButton(
                    child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Icon(
                          Icons.person_rounded,
                          size: 28,
                          color: Constant.primaryColor,
                        )),
                    // onSelected: (menuList) {
                    //   setState(() {
                    //     _selectedMenu = menuList.name;
                    //   });
                    // },
                    itemBuilder: (BuildContext context) {
                      print("User ID: ${Constant.id}");
                      return (isLogin == true)
                          ? <PopupMenuEntry>[
                              PopupMenuItem(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.UserProfilePage);
                                },
                                child: Text(Constant.language == '?lang=h'
                                    ? "मेरी प्रोफाइल"
                                    : "My Profile"),
                              )),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.MyCases);
                                    },
                                    child: Text(Constant.language == '?lang=h'
                                        ? "मेरे केस"
                                        : "My Cases")),
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.LanguageSelect);
                                      });
                                    },
                                    child: Text(Constant.language == '?lang=h'
                                        ? "भाषा/ Language"
                                        : "Language/ भाषा")),
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Log Out"),
                                              content: Text(
                                                  "Are you sure to Log Out?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    logout();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      // Navigator.of(context).pop();

                                      // logout();
                                      // getLoggedInState();
                                    },
                                    child: Text(Constant.language == '?lang=h'
                                        ? "लॉग आउट"
                                        : "Logout")),
                              ),
                            ]
                          : <PopupMenuEntry>[
                              PopupMenuItem(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.LoginPage);
                                  },
                                  child: Text(Constant.language == '?lang=h'
                                      ? "लॉगिन"
                                      : "Login"),
                                ),
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.LanguageSelect);
                                      });
                                    },
                                    child: Text(Constant.language == '?lang=h'
                                        ? "भाषा/ Language"
                                        : "Language/ भाषा")),
                              ),
                              // PopupMenuItem(
                              //    child: GestureDetector(
                              //      onTap: () {
                              //        Navigator.pushNamed(context, AppRoutes.SignUpPage);
                              //      },
                              //      child: const Text("Sign Up"),
                              //    ),
                              //  ),
                            ];
                    },
                  ),
                ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.pushNamed(context, AppRoutes.AboutPage);
                  //     },
                  //     child: buildCard("About $appName")),

                  isLoading
                      ? Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.width),
                            CircleProgressIndicator.circleIndicator,
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 2),
                          ],
                        ))
                      : Column(
                          children: [
                            const SizedBox(height: 28),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage: Images.logoImg,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Constant.language == '?lang=h'
                                  ? "बायोकेमिक मास्टर"
                                  : appName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            ListView.builder(
                                itemCount: aboutModelList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          Navigator.pushNamed(
                                              context, AppRoutes.AboutPage,
                                              arguments:
                                                  aboutModelList[index].text);
                                        } else if (index == 1) {
                                          Navigator.pushNamed(
                                              context, AppRoutes.MedicinePage,
                                              arguments:
                                                  aboutModelList[index].text);
                                        } else if (index == 2) {
                                          if (Constant.id == null ||
                                              Constant.id.isEmpty ||
                                              Constant.id == '') {
                                            Fluttertoast.showToast(
                                                msg: Constant.language ==
                                                        '?lang=h'
                                                    ? "कृपया पहले लॉगिन करें"
                                                    : "Please Login First");
                                            // Navigator.pushReplacementNamed(
                                            Navigator.pushNamed(
                                                context, AppRoutes.LoginPage);
                                          } else {
                                            Navigator.pushNamed(
                                                context, AppRoutes.ChapterPage);
                                          }
                                        } else {
                                          Navigator.pushNamed(
                                              context, AppRoutes.SearchPage,
                                              arguments:
                                                  aboutModelList[index].text);
                                        }
                                      },
                                      child: buildCard(
                                          aboutModelList[index].text!.trim()));
                                }),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: ConHeight.height,
        // height: MediaQuery.of(context).size.height / 11,
        child: Card(
          color: Constant.primaryColor,
          shape: CardShape.shape,
          elevation: CardShape.elevation,
          shadowColor: Constant.primaryColor,
          child: Center(
            child: Row(
              children: [
                const SizedBox(width: 12),
                const CircleAvatar(
                    radius: 20,
                    backgroundColor: Constant.primaryColor,
                    backgroundImage: Images.logoImg),
                const SizedBox(width: 16),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
