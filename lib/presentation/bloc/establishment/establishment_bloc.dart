import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/network/network_info_impl.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_checkin_data_use_case%20copy.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sync_data_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_profile_image_use_case.dart';

part 'establishment_event.dart';
part 'establishment_state.dart';

class EstablishmentBloc extends Bloc<EstablishmentEvent, EstablishmentState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;
  final GetProfileInformationUseCase getProfileInformationUseCase;
  final SyncDataUseCase syncDataUseCase;
  final ListenForCheckInDataUseCase listenForCheckInDataUseCase;
  final NetworkInfoImpl networkInfo;

  EstablishmentBloc(
      {this.listenForSessionUseCase,
      this.uploadProfileImageUseCase,
      this.getProfileInformationUseCase,
      this.syncDataUseCase,
      this.listenForCheckInDataUseCase,
      this.networkInfo})
      : super(EstablishmentInitial());

  StreamSubscription<Session> _sessionSubscription;
  StreamSubscription<List<CheckIn>> _checkInSubscription;
  Logger logger = Logger();

  @override
  Stream<EstablishmentState> mapEventToState(
    EstablishmentEvent event,
  ) async* {
    if (event is EstablishmentOnLoad) {
      yield EstablishmentState.copyWith(
        state,
        establishmentGetUserProgress: true,
      );
      

      _sessionSubscription?.cancel();
      _checkInSubscription?.cancel();

      _sessionSubscription = listenForSessionUseCase.stream().listen((session) {
        _checkInSubscription =
            listenForCheckInDataUseCase.stream().listen((listCheckIn) {
          add(GetUserData(user: session.user, checkIn: listCheckIn));
        });
      });
    } else if (event is GetUserData) {
      yield EstablishmentState.copyWith(
        state,
        establishmentGetUserProgress: false,
        user: event.user,
        localCheckInData: event.checkIn,
      );
    }

    if (event is ProfileImageOnUpload) {
      yield EstablishmentState.copyWith(
        state,
        profileUploadImageProgress: true,
      );
      try {
        await uploadProfileImageUseCase.execute(event.image);
        await getProfileInformationUseCase.execute();
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield EstablishmentState.copyWith(
          state,
          profileUploadImageProgress: false,
          profileUploadImageFailureMessage: errorhandler,
        );
      } catch (e) {
        logger.e(e);
        yield EstablishmentState.copyWith(
          state,
          profileUploadImageProgress: false,
          profileUploadImageFailureMessage: e,
        );
      }
    }

    if (event is OnSyncDataPressed) {
      yield EstablishmentState.copyWith(
        state,
        syncDataProgress: true,
      );
      try {
        if (await networkInfo.isConnected()) {
          await syncDataUseCase.execute();
        } else {
          throw Exception(
              "Connect to the internet to upload local data.");
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield EstablishmentState.copyWith(state,
            syncDataProgress: false, syncDataFailureMessage: errorhandler);
      } on Exception catch (e) {
        logger.e(e);
        yield EstablishmentState.copyWith(
          state,
          syncDataProgress: false,
          syncDataFailureMessage: e.toString(),
        );
      }
    }

    if (event is OnRefresh) {
      yield EstablishmentState.copyWith(
        state,
        establishmentGetUserProgress: true,
      );
      try {
        if (await networkInfo.isConnected()) {
          await getProfileInformationUseCase.execute();

          yield EstablishmentState.copyWith(
            state,
            establishementGetUserSuccessMessage: "Updated Successfully",
          );
        } else {
          throw Exception("Connect to the internet to refresh data");
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield EstablishmentState.copyWith(state,
            establishmentGetUserProgress: false,
            syncDataFailureMessage: errorhandler);
      } catch (e) {
        logger.e(e);
        yield EstablishmentState.copyWith(
          state,
          establishmentGetUserProgress: false,
          syncDataFailureMessage: e.message,
        );
      }
    }
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    _checkInSubscription?.cancel();
    return super.close();
  }
}
