import 'dart:convert';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/model/medicine_page/remedies_ind_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MedicineSearchService {
  static MedicineSearchService? _instance;

  MedicineSearchService._internal();

  static MedicineSearchService? getInstance() {
    _instance ??= MedicineSearchService._internal();
    return _instance;
  }

  Future<List<GetRemediesIndModel>?> getRemediesInd() async {
    List<GetRemediesIndModel> getRemediesIndModelList = [];
    for (int i = 1; i <= 10; i++) {
      Uri myUri = Uri.parse("${NetworkUtil.getRemediesIndUrl}rem_id=$i");
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
              getRemediesIndModelList;
            }
          }
        }
      }
    }
    return getRemediesIndModelList;
  }
}
