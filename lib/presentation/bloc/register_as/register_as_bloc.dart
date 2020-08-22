import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';

part 'register_as_event.dart';
part 'register_as_state.dart';

class RegisterAsBloc extends Bloc<RegisterAsEvent, RegisterAsState> {
  RegisterAsBloc() : super(RegisterAsInitial());

  @override
  Stream<RegisterAsState> mapEventToState(
    RegisterAsEvent event,
  ) async* {
    if (event is OnSelectRegistrationType) {
      if (event.selectedRegistrationType ==
          SelectedRegistrationType.Individual) {
        yield SelectIndividual();
      } else {
        yield SelectEstablishment();
      }
    }
  }
}
