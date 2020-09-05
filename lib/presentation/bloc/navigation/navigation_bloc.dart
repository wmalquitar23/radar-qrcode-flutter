import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/logout_use_case.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final LogoutUseCase logoutUseCase;
  final GetSessionUseCase getSessionUseCase;
  NavigationBloc({
    this.logoutUseCase,
    this.getSessionUseCase,
  }) : super(NavigationInitial());

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is OnLogout) {
      await logoutUseCase.execute();
      yield NavigationLogoutSuccess();
    } else if (event is OnNavigationLoad) {
      Session session = await getSessionUseCase.execute();

      if (session.user.role == "individual") {
        yield NavigationCheckUserRole(true);
      } else {
        yield NavigationCheckUserRole(false);
      }
    }
  }
}
