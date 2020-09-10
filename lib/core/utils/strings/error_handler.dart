import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';

import 'errors.dart';

class ErrorHandler {
  Logger logger = Logger();
  String dioErrorHandler(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        logger.e(error.message);
        return NO_INTERNET_CONNECTION;
        break;
      case DioErrorType.SEND_TIMEOUT:
        logger.e(error.message);
        return NO_INTERNET_CONNECTION;
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        logger.e(error.message);
        return NO_INTERNET_CONNECTION;
        break;
      case DioErrorType.CANCEL:
        logger.e(error.message);
        return NO_INTERNET_CONNECTION;
        break;
      case DioErrorType.DEFAULT:
        logger.e(error.message);
        return NO_INTERNET_CONNECTION;
        break;
      case DioErrorType.RESPONSE:
        logger.e(error.response.data);
        if (error.response.data != null) {
          StandardResponse errorResponse =
              StandardResponse.fromJson(error.response.data);
          logger.e(errorResponse.message);
          return errorResponse.message;
        } else {
          return error.message;
        }
        break;
      default:
        logger.e(error.message);
        return error.message;
        break;
    }
  }
}
