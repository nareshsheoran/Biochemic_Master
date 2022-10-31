// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/page/splash_page.dart';
import 'package:biochemic_master/auth/localdb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'Shared/routes.dart';
import 'package:flutter/services.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  if (foundation.kDebugMode) {
    debugPrint('release mode');
  } else {
    debugPrint('debug mode');
  }

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  LocalDataSaver.saveLoginData(false);
  runApp(MyApp());

// runApp(
//   DevicePreview(
//     enabled: true,
//     tools: const [...DevicePreview.defaultTools],
//     builder: (context) =>const MyApp(), // Wrap your app
//   ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
          primaryColor: Constant.primaryColor,
          iconTheme: IconThemeData(color: Constant.primaryColor)),
      home: SplashPage(),
      color: Constant.primaryColor,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
