import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/network/network_info_impl.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/encrypt.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_checkin_data_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_total_checkin_data_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sync_data_use_case.dart';

part 'individual_event.dart';
part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  final GetProfileInformationUseCase getProfileInformationUseCase;
  final NetworkInfoImpl networkInfo;
  final GetSessionUseCase getSessionUseCase;
  final ListenForCheckInDataUseCase listenForCheckInDataUseCase;
  final ListenForTotalCheckInDataUseCase listenForTotalCheckInDataUseCase;
  final SyncDataUseCase syncDataUseCase;

  IndividualBloc({
    this.listenForSessionUseCase,
    this.getProfileInformationUseCase,
    this.networkInfo,
    this.getSessionUseCase,
    this.listenForTotalCheckInDataUseCase,
    this.listenForCheckInDataUseCase,
    this.syncDataUseCase,
  }) : super(IndividualInitial());

  StreamSubscription<Session> _sessionSubscription;
  StreamSubscription<List<CheckIn>> _checkInSubscription;
  StreamSubscription<List<CheckIn>> _totalCheckInSubscription;
  Logger logger = Logger();
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
      _checkInSubscription?.cancel();
      _totalCheckInSubscription?.cancel();

      _sessionSubscription = listenForSessionUseCase.stream().listen((session) {
        _checkInSubscription =
            listenForCheckInDataUseCase.stream().listen((listCheckIn) {
          _totalCheckInSubscription = listenForTotalCheckInDataUseCase
              .stream()
              .listen((totalListCheckIn) {
            add(GetUserData(
                checkIn: listCheckIn, totalCheckin: totalListCheckIn));
          });
        });
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
            user: session.user,
            jsonQrCode: encrypted,
          ),
          localCheckInData: event.checkIn,
          totalScannedCheckInData: event.totalCheckin,
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

    if (event is OnSyncDataPressed) {
      yield IndividualState.copyWith(
        state,
        syncDataProgress: true,
      );
      try {
        if (await networkInfo.isConnected()) {
          await syncDataUseCase.execute();
        } else {
          throw Exception("Connect to the internet to upload local data.");
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield IndividualState.copyWith(state,
            syncDataProgress: false, syncDataFailureMessage: errorhandler);
      } on Exception catch (e) {
        logger.e(e);
        yield IndividualState.copyWith(
          state,
          syncDataProgress: false,
          syncDataFailureMessage: e.toString(),
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
