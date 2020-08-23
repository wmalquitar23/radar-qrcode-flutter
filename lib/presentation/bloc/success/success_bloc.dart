import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'success_event.dart';
part 'success_state.dart';

class SuccessBloc extends Bloc<SuccessEvent, SuccessState> {
  SuccessBloc() : super(SuccessInitial());

  @override
  Stream<SuccessState> mapEventToState(
    SuccessEvent event,
  ) async* {

    
  }

  void load(VoidCallback onboardCallback) async {
    await Future.delayed(Duration(milliseconds: 3000));
    if (onboardCallback != null) {
      onboardCallback();
    }
  }
}
