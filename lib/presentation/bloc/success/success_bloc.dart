import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';

part 'success_event.dart';
part 'success_state.dart';

class SuccessBloc extends Bloc<SuccessEvent, SuccessState> {
  final GetSessionUseCase getSessionUseCase;
  SuccessBloc({this.getSessionUseCase}) : super(SuccessInitial());

  @override
  Stream<SuccessState> mapEventToState(
    SuccessEvent event,
  ) async* {
    if (event is GetUserType) {
      Session session = await getSessionUseCase.execute();
      if (session.user.role == "individual") {
        yield GoToRouteState(route: INDIVIDUAL_HOME_ROUTE);
      } else {
        yield GoToRouteState(route: ESTABLISHMENT_HOME_ROUTE);
      }
    }
  }

  void load(VoidCallback onboardCallback) async {
    await Future.delayed(Duration(milliseconds: 3000));
    if (onboardCallback != null) {
      onboardCallback();
    }
  }
}
