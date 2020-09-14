import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/network/network_info_impl.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/encrypt.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';

part 'individual_event.dart';
part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  final GetProfileInformationUseCase getProfileInformationUseCase;
  final NetworkInfoImpl networkInfo;
  final GetSessionUseCase getSessionUseCase;
  IndividualBloc({
    this.listenForSessionUseCase,
    this.getProfileInformationUseCase,
    this.networkInfo,
    this.getSessionUseCase,
  }) : super(IndividualInitial());

  StreamSubscription<Session> _sessionSubscription;
  @override
  Stream<IndividualState> mapEventToState(
    IndividualEvent event,
  ) async* {
    if (event is IndividualOnLoad) {
      yield IndividualState.copyWith(
        state,
        individualGetuserProgress: true,
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
        yield IndividualState.copyWith(
          state,
          individualGetuserProgress: false,
          individualGetUserSuccess: IndividualGetUserSuccess(
              user: session.user, jsonQrCode: encrypted),
        );
      } else {
        _sessionSubscription?.cancel();
      }
    }

    if (event is OnRefresh) {
      yield IndividualState.copyWith(
        state,
        individualGetuserProgress: true,
      );
      try {
        if (await networkInfo.isConnected()) {
          await getProfileInformationUseCase.execute();

          yield IndividualState.copyWith(
            state,
            individualGetuserSuccessMessage: "Updated Successfully",
            individualGetuserProgress: false,
          );
        } else {
          throw Exception("Connect to the internet to refresh data");
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield IndividualState.copyWith(state,
            individualGetuserProgress: false,
            individualGetuserFailureMessage: errorhandler);
      } catch (e) {
        print(e);
        yield IndividualState.copyWith(
          state,
          individualGetuserProgress: false,
          individualGetuserFailureMessage: e.toString(),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
