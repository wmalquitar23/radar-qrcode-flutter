import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';

part 'establishment_event.dart';
part 'establishment_state.dart';

class EstablishmentBloc extends Bloc<EstablishmentEvent, EstablishmentState> {
  final ListenForSessionUseCase listenForSessionUseCase;

  EstablishmentBloc({this.listenForSessionUseCase})
      : super(EstablishmentInitial());

  StreamSubscription<Session> _sessionSubscription;

  @override
  Stream<EstablishmentState> mapEventToState(
    EstablishmentEvent event,
  ) async* {
    if (event is EstablishmentOnLoad) {
      yield EstablishmentProgress();

      _sessionSubscription?.cancel();

      _sessionSubscription = listenForSessionUseCase.stream().listen((session) {
        add(GetUserData(user: session.user));
      });
    } else if (event is GetUserData) {
      yield EstablishmentGetUserSuccess(user: event.user);
    }
  }
}
