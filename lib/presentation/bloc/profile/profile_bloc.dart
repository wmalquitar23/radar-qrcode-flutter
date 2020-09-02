import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_profile_image_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;
  ProfileBloc({
    this.listenForSessionUseCase,
    this.uploadProfileImageUseCase,
  }) : super(ProfileInitial());

  StreamSubscription<Session> _sessionSubscription;

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
      await uploadProfileImageUseCase.execute(event.image);
      
    }
  }
}
