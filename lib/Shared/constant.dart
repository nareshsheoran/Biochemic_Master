// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

String appName = "Biochemic Master";

class Constant {
  static String name = "";
  static String email = "";
  static String img = "";
  static String id = '';
  static String password = "";

  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.black;
}

class Images {
  static const AssetImage logoImg = AssetImage("assets/images/img.png");
}

class NetworkUtil {
  static String baseUrl = "https://mettlecrowsolutions.com/apps/apis/biochem_new/";
  static String getRemediesIndUrl = baseUrl + "get-rem-indications.php?";
  static String searchRemediesUrl = baseUrl + "search-indications.php?";
  static String fetchMedicineNameUrl = baseUrl + "get-rems.php";
  static String chapterUrl = baseUrl + "get-chapters.php";
  static String getAboutContentUrl = baseUrl + "get-about-content.php";
  static String fetchTotalSelectedChapterSymptomsUrl = baseUrl + "get-all-select-symps.php?";
  static String getIndicationUrl = baseUrl + "get-indications.php?";
  static String getSympCountUrl = baseUrl + "get-symp-count.php?";
  static String fetchSymptomRecordedUrl = baseUrl + "save-symptom.php?";
  static String getUnSelectedChapterSymptomsUrl = baseUrl + "get-unselect-symp.php?";
  static String getSelectedChapterSymptomsUrl = baseUrl + "get-selected-symps.php?";
  static String fetchDeleteSympUrl = baseUrl + "delete-select-symp.php?";
  static String getRemCount = baseUrl + "get-result.php?";
  static String getRemoveSymp = baseUrl + "remove-symp.php?";
  static String getLoginUrl = baseUrl + "login.php?";
  static String getMyCasesUrl = baseUrl + "get-user-cases.php?";
  static String fetchDeleteSelectSympUrl = baseUrl + "delete-select-symp.php?";
  static String fetchRecordRemSympDetailsUrl = baseUrl + "get-record-rem-symps.php?";
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
