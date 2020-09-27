import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_individual_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/verify_existing_mobile_number_use_case.dart';

part 'individual_basic_information_event.dart';
part 'individual_basic_information_state.dart';

class IndividualBasicInformationBloc extends Bloc<
    IndividualBasicInformationEvent, IndividualBasicInformationState> {
  final RegisterIndividualUseCase registerIndividualUseCase;
  final VerifyExistingMobileNumberUseCase verifyExistingMobileNumberUseCase;
  IndividualBasicInformationBloc(
      {this.registerIndividualUseCase, this.verifyExistingMobileNumberUseCase})
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
          event.userAddress,
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
    } else if (event is ValidateContactNumber) {
      final contactNum = event.contactNumber;

      if ((contactNum.length > 0 && contactNum[0] != '9') ||
          contactNum.length < 10) {
        yield ContactNumberIsInvalid(
          message: "Mobile number is invalid.",
          invalidType: 0,
        );
      } else if (contactNum.length == 10) {
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
