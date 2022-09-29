import 'dart:async';
import 'dart:io';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:biochemic_master/service/device_id_service.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future logout() async {
    setState(() {
      LocalDataSaver.saveLoginData(false);
      isLogin == false;
      LocalDataSaver.saveID(null);
      LocalDataSaver.saveID('');
      Constant.id == null;
      Constant.id == '';
      Constant.id = '';
      Fluttertoast.showToast(msg: "Logout Successfully");
      Navigator.pushReplacementNamed(context, AppRoutes.FrontPage);
    });
    // Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getLoggedInState();
    fetchValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
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
                          child: const Text("My Profile"),
                        )),
                        PopupMenuItem(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.MyCases);
                              },
                              child: const Text("My Cases")),
                        ),
                        PopupMenuItem(
                          child: GestureDetector(
                              onTap: () {
                                logout();
                                // getLoggedInState();
                              },
                              child: const Text("Logout")),
                        ),
                      ]
                    : <PopupMenuEntry>[
                        PopupMenuItem(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.LoginPage);
                            },
                            child: const Text("Login"),
                          ),
                        )
                      ];
              },
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    backgroundImage: Images.logoImg,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.AboutPage);
                      },
                      child: buildCard("About $appName")),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.MedicinePage);
                      },
                      child: buildCard("Remedies")),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.ChapterPage);
                      },
                      child: buildCard("Case Study")),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.SearchPage);
                      },
                      child: buildCard("Search Symptoms")),
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
