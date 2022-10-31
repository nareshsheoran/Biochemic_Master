// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';

String appName = "Biochemic Master";

class Constant {
  static String name = "";
  static String email = "";
  static String img = "";
  static String id = '';
  static String? language;
  static String password = "";

  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.black;
}

class Images {
  static const AssetImage logoImg = AssetImage("assets/images/img.png");
}

class NetworkUtil {
  static String baseUrl =
      "https://mettlecrowsolutions.com/apps/apis/biochem_newW/";
  static String getLoginUrl = baseUrl + "login.php?";
  static String chapterUrlCh = baseUrl + "get-chapters.php";
  static String getRemediesIndUrl = baseUrl + "get-rem-indications.php?";
  static String fetchMedicineNameUrlCh = baseUrl + "get-rems.php";
  static String getAboutContentUrlCh = baseUrl + "get-about-content.php";
  static String getRemCountCh = baseUrl + "get-result.php";
  static String fetchTotalSelectedChapterSymptomsUrl =
      baseUrl + "get-all-select-symps.php?";
  static String getIndicationUrl = baseUrl + "get-indications.php?";
  static String getSympCountUrl = baseUrl + "get-symp-count.php?";
  static String fetchSymptomRecordedUrl = baseUrl + "save-symptom.php?";
  static String getUnSelectedChapterSymptomsUrl =
      baseUrl + "get-unselect-symp.php?";
  static String getSelectedChapterSymptomsUrl =
      baseUrl + "get-selected-symps.php?";
  static String fetchDeleteSympUrl = baseUrl + "delete-select-symp.php?";
  static String getRemoveSymp = baseUrl + "remove-symp.php?";
  static String getMyCasesUrl = baseUrl + "get-user-cases.php?";
  static String fetchDeleteSelectSympUrl = baseUrl + "delete-select-symp.php?";
  static String fetchRecordRemSympDetailsUrl =
      baseUrl + "get-record-rem-symps.php?";
  static String fetchFrontPageLinkUrlCh = baseUrl + "get-main-links.php";

  static String searchRemediesUrl = baseUrl + "search-indications.php?";
}

class CardShape {
  static double elevation = 10;
  static double height = 12;
  static final shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
}

class ConHeight {
  static double height = 68;
}

class CircleProgressIndicator {
  static CircularProgressIndicator circleIndicator =
      CircularProgressIndicator(color: Constant.primaryColor, strokeWidth: 3);
}
