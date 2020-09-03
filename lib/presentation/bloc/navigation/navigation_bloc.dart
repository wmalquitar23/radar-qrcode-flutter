import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/domain/usecases/logout_use_case.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final LogoutUseCase logoutUseCase;
  NavigationBloc({this.logoutUseCase}) : super(NavigationInitial());

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is OnLogout) {
      await logoutUseCase.execute();
      yield NavigationLogoutSuccess();
    }
  }
}
