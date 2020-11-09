import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_offline_data_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/logout_use_case.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final LogoutUseCase logoutUseCase;
  final GetSessionUseCase getSessionUseCase;
  final GetOfflineUseCase getOfflineUseCase;
  NavigationBloc({
    this.logoutUseCase,
    this.getSessionUseCase,
    this.getOfflineUseCase,
  }) : super(NavigationInitial());

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is OnLogout) {
      try {
        await logoutUseCase.execute();
      } catch (e) {
        Logger().e(e);
      }
      yield NavigationLogoutSuccess();
    } else if (event is OnNavigationLoad) {
      try {
        Session session = await getSessionUseCase.execute();
        List<CheckIn> offlineScans = await getOfflineUseCase.execute();

        if (session.user.role == "individual") {
          yield NavigationCheckUserRole(true, offlineScans.length > 0);
        } else {
          yield NavigationCheckUserRole(false, offlineScans.length > 0);
        }
      } catch (e) {
        Logger().e(e);
      }
    }
  }
}
