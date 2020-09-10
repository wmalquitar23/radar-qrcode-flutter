import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_establishment_request.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';

class RestClient {
  Dio _dio;
  Logger logger = Logger();

  RestClient(this._dio);

  bool hasToken() {
    return _dio.options.headers.containsKey("Authorization");
  }

  StandardResponse apiCatcher(StandardResponse standardResponse) {
    if (standardResponse.code != 200 && standardResponse.code != 201) {
      throw Exception(standardResponse.message);
    }
    return standardResponse;
  }

  Future<StandardResponse> registerIndividual(dynamic data) async {
    Response response = await _dio.post("/register/individual", data: data);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> otpMobileNumber(String otp) async {
    Response response = await _dio.post("/register/otp/", data: {
      "contactNumber": otp,
    });
    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> registerEstablishment(
      RegisterEstablishmentRequest registerEstablishmentRequest) async {
    Response response = await _dio.post("/register/establishment",
        data: registerEstablishmentRequest);

    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> checkin(
      String individualId, String establishmentId) async {
    Response response = await _dio.post("/checkin", data: {
      "individualId": individualId,
      "establishmentId": establishmentId
    });

    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> getAllIndividuals() async {
    Response response = await _dio.get("/individuals");

    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> getAllEstablishments() async {
    Response response = await _dio.get("/establishments");

    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> login(String contactNumber, String pin) async {
    Response response = await _dio
        .post("/login", data: {"contactNumber": contactNumber, "pin": pin});

    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> fileUpload(File file) async {
    var data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
      )
    });
    Response response = await _dio.post("/file/upload", data: data);
    return StandardResponse.fromJson(response.data);
  }

  Future<StandardResponse> downloadfile(String file) async {
    Response response = await _dio.get("/file/$file");

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> updateUser(dynamic data, String id) async {
    Response response = await _dio.patch("/users/$id", data: data);
    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> verifyOtp(String otp) async {
    Response response = await _dio.post("/verify/otp", data: {
      "code": otp,
    });

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> verifyMobileNumber(String mobileNumber) async {
    Response response = await _dio.get("/identity/$mobileNumber");

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> getProfileInfo() async {
    Response response = await _dio.get("/profile");
    print(response);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> changePin(
      String oldPin, String newPin, String id) async {
    Response response = await _dio
        .patch("/users/$id/pin", data: {"oldPin": oldPin, "newPin": newPin});

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> checkIn(String id) async {
    Response response =
        await _dio.post("/checkin", data: {"individualId": id});

    return apiCatcher(StandardResponse.fromJson(response.data));
  }
}
