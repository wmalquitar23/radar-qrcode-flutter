import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_individual_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/verify_existing_mobile_number_use_case.dart';

part 'change_contact_number_event.dart';
part 'change_contact_number_state.dart';

class ChangeContactNumberBloc
    extends Bloc<ChangeContactNumberEvent, ChangeContactNumberState> {
  final RegisterIndividualUseCase registerIndividualUseCase;
  final VerifyExistingMobileNumberUseCase verifyExistingMobileNumberUseCase;
  ChangeContactNumberBloc(
      {this.registerIndividualUseCase, this.verifyExistingMobileNumberUseCase})
      : super(ChangeContactNumberInitial());

  Logger logger = Logger();

  @override
  Stream<ChangeContactNumberState> mapEventToState(
    ChangeContactNumberEvent event,
  ) async* {
    if (event is ContinueButtonPressed) {
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
