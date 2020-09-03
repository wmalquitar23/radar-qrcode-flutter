import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_profile_image_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;
  final GetProfileInformationUseCase getProfileInformationUseCase;
  ProfileBloc(
      {this.listenForSessionUseCase,
      this.uploadProfileImageUseCase,
      this.getProfileInformationUseCase})
      : super(ProfileInitial());

  StreamSubscription<Session> _sessionSubscription;

  Logger logger = Logger();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileOnLoad) {
      yield ProfileGetDataLoading();

      _sessionSubscription?.cancel();

      _sessionSubscription = listenForSessionUseCase.stream().listen((session) {
        add(GetUserData(user: session.user));
      });
    } else if (event is GetUserData) {
      yield ProfileGetDataSuccess(user: event.user);
    }

    if (event is ProfileImageOnUpload) {
      yield ProfileUploadingImageLoading();
      try {
        await uploadProfileImageUseCase.execute(event.image);
        await getProfileInformationUseCase.execute();
        
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield ProfileUploadingImageFailure(error: errorhandler);
      } catch (e) {
        logger.e(e);
        yield ProfileUploadingImageFailure(error: e);
      }
    }
  }
}
