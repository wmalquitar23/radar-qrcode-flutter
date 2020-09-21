import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_verification_id_use_case.dart';

part 'verification_id_event.dart';
part 'verification_id_state.dart';

class VerificationIdBloc
    extends Bloc<VerificationIdEvent, VerificationIdState> {
  final UploadVerificationIdUseCase uploadVerificationIdUseCase;
  VerificationIdBloc({this.uploadVerificationIdUseCase})
      : super(VerificationIdInitial());

  Logger logger = Logger();

  @override
  Stream<VerificationIdState> mapEventToState(
    VerificationIdEvent event,
  ) async* {
    if (event is VerificationIdOnUpload) {
      yield VerificationIdUploadingImageLoading();
      try {
        await uploadVerificationIdUseCase.execute(event.image);
        yield VerificationIdUploadingImageSuccess();
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield VerificationIdUploadingImageFailure(error: errorhandler);
      } catch (e) {
        logger.e(e);
        yield VerificationIdUploadingImageFailure(error: e.toString());
      }
    }
  }
}
