import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/errors.dart';
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
          "0"+event.contactNumber,
          event.address,
          event.birthDate,
          event.gender,
        );
        yield RegisterDone();
      } on DioError catch (e) {
        switch (e.type) {
          case DioErrorType.CONNECT_TIMEOUT:
            logger.e(e.message);
            yield RegisterFailure(error: e.message);
            break;
          case DioErrorType.RESPONSE:
            logger.e(e.message);
            yield RegisterFailure(error: e.message);
            break;
          default:
            logger.e(e.message);
            yield RegisterFailure(error: unknownError(e.message));
            break;
        }
      } catch (e) {
        logger.e(e);
        yield RegisterFailure(error: e);
      }
    }
  }
}
