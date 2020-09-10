import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/network/network_info_impl.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/checkin_use_case.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final CheckInUseCase checkInUseCase;
  final NetworkInfoImpl networkInfo;
  UserDetailsBloc({this.checkInUseCase, this.networkInfo})
      : super(UserDetailsInitial());

  Logger logger = Logger();

  @override
  Stream<UserDetailsState> mapEventToState(
    UserDetailsEvent event,
  ) async* {
    if (event is OnLoadUserDetail) {
      yield UserDetailsState.copyWith(
        state,
        userInformation: UserMapper().fromMap(event.userInformation),
      );
    } else if (event is OnUserApprove) {
      yield UserDetailsState.copyWith(
        state,
        userInformation: event.user,
        userApproveLoading: true,
      );
      try {
        if (await networkInfo.isConnected()) {
          await checkInUseCase.execute(event.user, true);
        } else {
          await checkInUseCase.execute(event.user, false);
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        logger.e(errorhandler);
      } catch (e) {
        logger.e(e);
      }
      yield UserDetailsState.copyWith(
        state,
        userInformation: event.user,
        userApproveLoading: false,
        userApproveDone: true,
      );
    }
  }
}
