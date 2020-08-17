import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc([SplashState initialState]) : super(initialState ?? SplashState());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    try {
      yield SplashState();
    } catch (_, stackTrace) {
      developer.log('$_', name: 'SplashBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  void load(VoidCallback onboardCallback) async {
    await Future.delayed(Duration(milliseconds: 3000));
    if (onboardCallback != null) {
      onboardCallback();
    }
  }
}
