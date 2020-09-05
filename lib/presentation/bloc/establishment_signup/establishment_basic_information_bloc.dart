import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_establishment_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/verify_existing_mobile_number_use_case.dart';

part 'establishment_basic_information_event.dart';
part 'establishment_basic_information_state.dart';

class EstablishmentBasicInformationBloc
    extends Bloc<EstablishmentBasicInformationEvent, EstablishmentBasicInformationState> {
  final RegisterEstablishmentUseCase registerEstablishmentUseCase;
  final VerifyExistingMobileNumberUseCase verifyExistingMobileNumberUseCase;
  EstablishmentBasicInformationBloc(
      {this.registerEstablishmentUseCase,
      this.verifyExistingMobileNumberUseCase})
      : super(EstablishmentBasicInformationInitial());

  Logger logger = Logger();
  @override
  Stream<EstablishmentBasicInformationState> mapEventToState(
    EstablishmentBasicInformationEvent event,
  ) async* {
    if (event is RegisterPressed) {
      yield RegisterProgress();
      try {
        await registerEstablishmentUseCase.execute(
          establishmentName: event.establishmentName,
          pin: event.pin,
          contactNumber: event.contactNumber,
          address: event.address,
        );
        yield RegisterDone();
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield RegisterFailure(error: errorhandler);
      } catch (e) {
        logger.e(e);
        yield RegisterFailure(error: e);
      }
    } else if (event is ValidateContactNumber) {
      final contactNumLength = event.contactNumber.length;

      if (contactNumLength < 10) {
        yield ContactNumberIsInvalid(
          message: "Mobile number is invalid.",
          invalidType: 0,
        );
      } else if (contactNumLength == 10) {
        yield ContactNumberValidationInProgress();
        try {
          final bool numberIsAlreadyUsed =
              await verifyExistingMobileNumberUseCase
                  .execute(event.contactNumber);

          if (!numberIsAlreadyUsed) {
            yield ContactNumberIsValid();
          } else {
            yield ContactNumberIsInvalid(
              message: "Mobile number is already used.",
              invalidType: 1,
            );
          }
        } on DioError catch (e) {
          String errorhandler = ErrorHandler().dioErrorHandler(e);
          yield ContactNumberValidationFailure(error: errorhandler);
        } catch (e) {
          logger.e(e);
          yield ContactNumberValidationFailure(error: e);
        }
      }
    }
  }
}