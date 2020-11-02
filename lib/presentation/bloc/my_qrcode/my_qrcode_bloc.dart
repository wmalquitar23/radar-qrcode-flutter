import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/encrypt.dart';
import 'package:radar_qrcode_flutter/core/utils/qr_code/poster_util.dart';
import 'package:radar_qrcode_flutter/core/utils/qr_code/sticker_util.dart';
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
      if (event.downloadType == QRDownloadType.poster) {
        final posterByteData = await PosterUtil().generateImageByteData(
          user: event.user,
          qrData: event.qrData,
        );

        try {
          await saveImage(
            event.user.displayId,
            event.downloadType.getValue,
            posterByteData,
          );

          ToastUtil.showToast(
              event.buildContext, "Poster Downloaded Succesfully!");
        } catch (e) {
          ToastUtil.showToast(
              event.buildContext, "Something went wrong! Please try again.");
        }
      } else {
        final stickerByteData = await StickerUtil().generateImageByteData(
          user: event.user,
          qrData: event.qrData,
        );

        try {
          await saveImage(
            event.user.displayId,
            event.downloadType.getValue,
            stickerByteData,
          );

          ToastUtil.showToast(
              event.buildContext, "Sticker Downloaded Succesfully!");
        } catch (e) {
          ToastUtil.showToast(
              event.buildContext, "Something went wrong! Please try again.");
        }
      }
    }
  }

  Future<void> saveImage(
    String displayId,
    String type,
    ByteData image,
  ) async {
    final albumName = "Radar";

    Directory directory = await getTemporaryDirectory();
    String path = directory.path;
    print(path);

    await Directory('$path/$albumName').create(recursive: true);
    String savePath = '$path/$albumName/$displayId-$type.png';

    File(savePath).writeAsBytesSync(image.buffer.asInt8List());

    if (savePath != null) {
      GallerySaver.saveImage(
        savePath,
        albumName: albumName,
      ).then(
        (bool val) {
          print(val);
        },
      );
    }

    return false;
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
