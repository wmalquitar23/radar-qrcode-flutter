import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class LocalDataClient {

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  Future<Map<String, dynamic>> getProvince() async {
    return await parseJsonFromAssets("assets/local/address/province.json");
  }

  Future<Map<String, dynamic>> getCityOrMunicipality() async {
    return await parseJsonFromAssets("assets/local/address/citymun.json");
  }

  Future<Map<String, dynamic>> getBarangay() async {
    return await parseJsonFromAssets("assets/local/address/brgy.json");
  }
}
