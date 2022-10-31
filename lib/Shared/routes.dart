// ignore_for_file: constant_identifier_names

import 'package:biochemic_master/Shared/page/dashboard_page.dart';
import 'package:biochemic_master/Shared/page/front_page.dart';
import 'package:biochemic_master/Shared/page/lang_select.dart';
import 'package:biochemic_master/Shared/page/splash_page.dart';
import 'package:biochemic_master/auth/user_profile.dart';
import 'package:biochemic_master/front_icon_page/login_page.dart';
import 'package:biochemic_master/front_icon_page/my_cases.dart';
import 'package:biochemic_master/front_icon_page/sign_up_page.dart';
import 'package:biochemic_master/page/about_app_page/about_page.dart';
import 'package:biochemic_master/page/case_study_page/chapter_page.dart';
import 'package:biochemic_master/page/case_study_page/repertorise_page.dart';
import 'package:biochemic_master/page/case_study_page/result_page.dart';
import 'package:biochemic_master/page/case_study_page/selected_symptoms_page.dart';
import 'package:biochemic_master/page/case_study_page/symptoms_page.dart';
import 'package:biochemic_master/page/remedies_page/medicine_detail_page.dart';
import 'package:biochemic_master/page/remedies_page/medicine_page.dart';
import 'package:biochemic_master/page/search_page/detail_page.dart';
import 'package:biochemic_master/page/search_page/search_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String SplashPage = "Splash Page";
  static const String DashboardPage = "Dashboard Page";
  static const String MedicinePage = "Medicine Page";
  static const String DetailsPage = "Details Page";
  static const String SearchPage = "Search Page";
  static const String FrontPage = "Front Page";
  static const String ChapterPage = "Chapter Page";
  static const String SymptomsPage = "Symptoms Page";
  static const String RepertorisePage = "Repertorise Page";
  static const String SelectedSymptomsPage = "Selected Symptoms Page";
  static const String AboutPage = "About Page";
  static const String MedicineDetailsPage = "Medicine Details Page";
  static const String LoginPage = "Login Page";
  static const String SignUpPage = "SignUp Page";
  static const String MyCases = "My Cases";
  static const String UserProfilePage = "User Profile Page";
  static const String ResultPage = "Result Page";
  static const String LanguageSelect = "Language Select";
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.SplashPage: (context) => const SplashPage(),
  AppRoutes.DashboardPage: (context) => const DashboardPage(),
  AppRoutes.MedicinePage: (context) => const MedicinePage(),
  AppRoutes.DetailsPage: (context) => const DetailsPage(),
  AppRoutes.SearchPage: (context) => const SearchPage(),
  AppRoutes.FrontPage: (context) => const FrontPage(),
  AppRoutes.ChapterPage: (context) => const ChapterPage(),
  AppRoutes.SymptomsPage: (context) => const SymptomsPage(),
  AppRoutes.RepertorisePage: (context) => const RepertorisePage(),
  AppRoutes.SelectedSymptomsPage: (context) => const SelectedSymptomsPage(),
  AppRoutes.AboutPage: (context) => const AboutPage(),
  AppRoutes.MedicineDetailsPage: (context) => const MedicineDetailsPage(),
  AppRoutes.LoginPage: (context) => const LoginPage(),
  AppRoutes.SignUpPage: (context) => const SignUpPage(),
  AppRoutes.MyCases: (context) => const MyCases(),
  AppRoutes.UserProfilePage: (context) => const UserProfilePage(),
  AppRoutes.ResultPage: (context) => const ResultPage(),
  AppRoutes.LanguageSelect: (context) => const LanguageSelect(),
};
