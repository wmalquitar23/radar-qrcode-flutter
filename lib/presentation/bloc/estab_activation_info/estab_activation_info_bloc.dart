import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';

part 'estab_activation_info_event.dart';
part 'estab_activation_info_state.dart';

class EstabActivationInfoBloc
    extends Bloc<EstabActivationInfoEvent, EstabActivationInfoState> {
  final GetProfileInformationUseCase getProfileInformationUseCase;
  final GetSessionUseCase getSessionUseCase;
  EstabActivationInfoBloc({
    this.getProfileInformationUseCase,
    this.getSessionUseCase,
  }) : super(EstabActivationInfoInitial());

  @override
  Stream<EstabActivationInfoState> mapEventToState(
    EstabActivationInfoEvent event,
  ) async* {
    if (event is EstablishmentInfoOnLoad) {
      yield GetUserInformationLoading();

      try {
        getProfileInformationUseCase.execute();
        Session session = await getSessionUseCase.execute();
        yield GetUserInformationSuccess(user: session.user);
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield GetUserInformationFailure(error: errorhandler);
      } catch (e) {
        yield GetUserInformationFailure(error: e);
      }
    }
  }
}
