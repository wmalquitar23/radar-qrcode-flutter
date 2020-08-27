import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';

class RestClient {
  Dio _dio;

  RestClient(this._dio);

  StandardResponse apiCatcher(StandardResponse standardResponse) {
    if (standardResponse.code != 200 && standardResponse.code != 201) {
      throw Exception(standardResponse.code);
    }
    return standardResponse;
  }

  Future<StandardResponse> registerIndividual(dynamic data) async {
    Response response = await _dio.post("/register/individual", data: data);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> otpMobileNumber(String otp) async {
    Response response = await _dio.post("/otp/mobile-number", data: {
      "contactNumber": otp,
    });
    Logger().i(response);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> verifyOtp(String otp) async {
    Response response = await _dio.post("/verify/mobile-number", data: {
      "code": otp,
    });

    return apiCatcher(StandardResponse.fromJson(response.data));
  }
}
