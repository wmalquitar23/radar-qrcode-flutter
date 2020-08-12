import 'package:dio/dio.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';

class RestClient {
  Dio _dio;

  RestClient(this._dio);

  Future<StandardResponse> register(String firstName, String lastName,
      String pin, String contactNumber, String address) async {
    Response response = await _dio.post("/register/individual", data: {
      "firstname": firstName,
      "lastname": lastName,
      "pin": pin,
      "contactNumber": contactNumber,
      "address": {"name": address},
    });

    return StandardResponse.fromJson(response.data);
  }
}
