import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/encrypt.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';

part 'my_qrcode_event.dart';
part 'my_qrcode_state.dart';

class MyQRCodeBloc extends Bloc<MyQRCodeEvent, MyQRCodeState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  final GetProfileInformationUseCase getProfileInformationUseCase;
  final GetSessionUseCase getSessionUseCase;
  MyQRCodeBloc({
    this.listenForSessionUseCase,
    this.getProfileInformationUseCase,
    this.getSessionUseCase,
  }) : super(MyQRCodeInitial());

  StreamSubscription<Session> _sessionSubscription;
  @override
  Stream<MyQRCodeState> mapEventToState(
    MyQRCodeEvent event,
  ) async* {
    if (event is UserOnLoad) {
      yield MyQRCodeState.copyWith(
        state,
        getUserInProgress: true,
      );
      _sessionSubscription?.cancel();
      _sessionSubscription = listenForSessionUseCase.stream().listen((session) {
        add(GetUserData());
      });
    } else if (event is GetUserData) {
      Session session = await getSessionUseCase.execute();
      if (session?.token != null) {
        String result = qrCodeObject(session?.user);
        var encrypted = await encryptAESCryptoJS(result);
        yield MyQRCodeState.copyWith(
          state,
          getUserInProgress: false,
          getUserSuccess:
              GetUserSuccess(user: session.user, jsonQrCode: encrypted),
        );
      } else {
        _sessionSubscription?.cancel();
      }
    } else if (event is OnDownloadButtonClick) {
      if (event.downloadType == DownloadType.poster) {
        // Download Poster
        print("Poster :" + event.qrData);
        ToastUtil.showToast(event.buildContext, "Poster Downloaded Succesfully!");
      } else {
        // Download Sticker
        print("Sticker :" + event.qrData);
        ToastUtil.showToast(event.buildContext, "Sticker Downloaded Succesfully!");
      }
    }
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
