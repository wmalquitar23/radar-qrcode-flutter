import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';

class ErrorHandler {
  Logger logger = Logger();
  String dioErrorHandler(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        logger.e(error.message);
        return error.message;
        break;
      case DioErrorType.RESPONSE:
        StandardResponse errorResponse = StandardResponse.fromJson(error.response.data);
        logger.e(errorResponse.message);
        return errorResponse.message;
        break;
      default:
        logger.e(error.message);
        return error.message;
        break;
    }
  }
}
