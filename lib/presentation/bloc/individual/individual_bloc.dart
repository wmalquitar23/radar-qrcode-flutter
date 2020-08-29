import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';

part 'individual_event.dart';
part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  final ListenForSessionUseCase listenForSessionUseCase;
  IndividualBloc({this.listenForSessionUseCase}) : super(IndividualInitial());

  StreamSubscription<Session> _sessionSubscription;
  @override
  Stream<IndividualState> mapEventToState(
    IndividualEvent event,
  ) async* {
    if (event is IndividualOnLoad) {
      yield IndividualProgress();

      _sessionSubscription?.cancel();

      _sessionSubscription = listenForSessionUseCase.stream().listen((session) {
        add(GetUserData(user: session.user));
      });
    } else if (event is GetUserData) {
      yield IndividualGetUserSuccess(user: event.user);
    }
  }
}
