import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/domain/usecases/otp_verification_use_case.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final OtpVerificationUseCase otpVerificationUseCase;
  VerificationBloc({this.otpVerificationUseCase})
      : super(VerificationInitial());

  Logger logger = Logger();
  @override
  Stream<VerificationState> mapEventToState(
    VerificationEvent event,
  ) async* {
    if (event is OnContinueButtonPressed) {
      yield VerificationProgress();
      try {
        await otpVerificationUseCase.execute(event.otp);
        yield VerificationSuccess();
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield VerificationFailure(error: errorhandler);
      } catch (e) {
        logger.e(e);
        yield VerificationFailure(error: e);
      }
    }
  }
}
