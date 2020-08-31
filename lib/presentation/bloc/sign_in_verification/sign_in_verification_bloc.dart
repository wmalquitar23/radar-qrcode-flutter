import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_service.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/dependency_instantiator.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sign_in_use_case.dart';

part 'sign_in_verification_event.dart';
part 'sign_in_verification_state.dart';

class SignInVerificationBloc
    extends Bloc<SignInVerificationEvent, SignInVerificationState> {
  SignInVerificationBloc() : super(SignInVerificationInitial());

  final SignInUseCase _signInUseCase = sl.get<SignInUseCase>();
  final NavigatorService _navigatorService = sl.get<NavigatorService>();

  @override
  Stream<SignInVerificationState> mapEventToState(
    SignInVerificationEvent event,
  ) async* {
    if (event is SignIn) {
      yield* _signIn(event);
    }
  }

  Stream<SignInVerificationState> _signIn(SignIn event) async* {
    yield ButtonLoading();

    try {
      final User user =
          await _signInUseCase.execute(event.contactNumber, event.pin);

      _navigatorService.pushNamedAndRemoveUntil(
          user.role == UserType.individual.toString()
              ? INDIVIDUAL_HOME_ROUTE
              : ESTABLISHMENT_HOME_ROUTE);
    } on DioError catch (_) {}
  }

  void onSignIn(String contactNumber, String pin) {
    add(SignIn(contactNumber: contactNumber, pin: pin));
  }
}
