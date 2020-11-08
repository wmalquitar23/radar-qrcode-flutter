import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/network/network_info_impl.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/checkin_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';

part 'establishment_details_event.dart';
part 'establishment_details_state.dart';

class EstablishmentDetailsBloc
    extends Bloc<EstablishmentDetailsEvent, EstablishmentDetailsState> {
  final CheckInUseCase checkInUseCase;
  final NetworkInfoImpl networkInfo;
  final GetSessionUseCase getSessionUseCase;
  EstablishmentDetailsBloc({
    this.checkInUseCase,
    this.networkInfo,
    this.getSessionUseCase,
  }) : super(EstablishmentDetailsInitial());
  Logger logger = Logger();

  @override
  Stream<EstablishmentDetailsState> mapEventToState(
    EstablishmentDetailsEvent event,
  ) async* {
    if (event is OnLoadUserDetail) {
      Session session = await getSessionUseCase.execute();
      yield EstablishmentDetailsState.copyWith(
        state,
        establishmentInformation: UserMapper().fromMap(event.userInformation),
        getCurrentUser: session.user,
        dateTime: DateTime.now(),
      );
    } else if (event is OnUserApprove) {
      yield EstablishmentDetailsState.copyWith(
        state,
        establishmentInformation: event.user,
        establishmentApproveLoading: true,
      );
      try {
        if (await networkInfo.isConnected()) {
          await checkInUseCase.execute(
            event.user,
            true, //has internet connection
            accessType: event.accessLogType,
            dateTime: event.dateTime,
          );
        } else {
          await checkInUseCase.execute(
            event.user,
            false, //no internet connection
            accessType: event.accessLogType,
            dateTime: event.dateTime,
          );
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        logger.e(errorhandler);
      } catch (e) {
        logger.e(e);
      }
      yield EstablishmentDetailsState.copyWith(
        state,
        establishmentInformation: event.user,
        establishmentApproveLoading: false,
        establishmentApproveDone: true,
      );
    }
  }
}
