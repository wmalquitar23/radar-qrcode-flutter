import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_establishment_request.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_individual_request.dart';
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

  Future<StandardResponse> registerIndividual(
      RegisterIndividualRequest data) async {
    Response response = await _dio.post("/auth/register", data: data);
    print(response);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> register(RegisterIndividualRequest data) async {
    Response response = await _dio.post("/auth/register", data: data);
    print(response);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> otpMobileNumber(String otp) async {
    Response response = await _dio.post("/otp/generate", data: {
      "contactNumber": otp,
    });
    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> registerEstablishment(
      RegisterEstablishmentRequest registerEstablishmentRequest) async {
    Response response =
        await _dio.post("/auth/register", data: registerEstablishmentRequest);

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> checkin(
      String individualId, String establishmentId) async {
    Response response = await _dio.post("/checkin", data: {
      "individualId": individualId,
      "establishmentId": establishmentId
    });

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> getAllIndividuals() async {
    Response response = await _dio.get("/individuals");

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> getAllEstablishments() async {
    Response response = await _dio.get("/establishments");

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> login(String contactNumber, String pin) async {
    Response response = await _dio.post("/auth/login",
        data: {"contactNumber": contactNumber, "pin": pin});

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> fileUpload(File file) async {
    var data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
      )
    });
    Response response = await _dio.post("/files", data: data);
    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> submitRequirements(dynamic data) async {
    Response response = await _dio.post("/requirements", data: data);
    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> downloadfile(String file) async {
    Response response = await _dio.get("/file/$file");

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> updateUser(dynamic data, String id) async {
    Response response = await _dio.patch("/users/$id", data: data);
    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> verifyOtp(String otp, String contactNumber) async {
    Response response = await _dio.post("/otp/verify", data: {
      "otp": otp,
      "contactNumber": contactNumber,
    });

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<bool> verifyMobileNumber(String mobileNumber) async {
    try {
      await _dio.head("/users?contactNumber=$mobileNumber");
      return true;
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }

  Future<StandardResponse> getProfileInfo() async {
    Response response = await _dio.get("/users/getProfile");

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> changePin(
      String oldPin, String newPin, String id) async {
    Response response = await _dio
        .patch("/users/$id/pin", data: {"oldPin": oldPin, "newPin": newPin});

    return apiCatcher(StandardResponse.fromJson(response.data));
  }

  Future<StandardResponse> checkIn(String id, {DateTime dateTime}) async {
    Response response = await _dio.post("/access-logs", data: {
      "id": id,
      "createdAt": dateTime != null ? dateTime : "",
    });

    return apiCatcher(StandardResponse.fromJson(response.data));
  }
}
