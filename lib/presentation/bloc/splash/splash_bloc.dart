import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/data/models/app_info.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_app_info_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetSessionUseCase getSessionUseCase;
  final GetAppInfoUseCase getAppInfoUseCase;
  SplashBloc({
    this.getSessionUseCase,
    this.getAppInfoUseCase,
  }) : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is GetSession) {
      yield SplashProgress();
      Session session = await getSessionUseCase.execute();
      AppInfo appInfo = await getAppInfoUseCase.execute();

      yield AppInformation(appInfo: appInfo);
      await Future<void>.delayed(Duration(milliseconds: 3000));
      if (session != null) {
        if (session.user.role == "individual") {
          yield AppHasSession(INDIVIDUAL_HOME_ROUTE);
        } else {
          yield AppHasSession(ESTABLISHMENT_HOME_ROUTE);
        }
      } else {
        yield AppHasNoSession();
      }
    }
  }
}
