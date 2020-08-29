import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_individual_use_case.dart';

part 'individual_basic_information_event.dart';
part 'individual_basic_information_state.dart';

class IndividualBasicInformationBloc extends Bloc<
    IndividualBasicInformationEvent, IndividualBasicInformationState> {
  final RegisterIndividualUseCase registerIndividualUseCase;
  IndividualBasicInformationBloc({this.registerIndividualUseCase})
      : super(IndividualBasicInformationInitial());

  Logger logger = Logger();
  @override
  Stream<IndividualBasicInformationState> mapEventToState(
    IndividualBasicInformationEvent event,
  ) async* {
    if (event is RegisterPressed) {
      yield RegisterProgress();
      try {
        await registerIndividualUseCase.execute(
          event.firstName,
          event.lastName,
          event.middleName,
          event.pin,
          event.contactNumber,
          event.address,
          event.birthDate,
          event.gender,
        );
        yield RegisterDone();
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield RegisterFailure(error: errorhandler);
      } catch (e) {
        logger.e(e);
        yield RegisterFailure(error: e);
      }
    }
  }
}
