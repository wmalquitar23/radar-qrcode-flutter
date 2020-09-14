import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sign_in_use_case.dart';

part 'sign_in_verification_event.dart';
part 'sign_in_verification_state.dart';

class SignInVerificationBloc
    extends Bloc<SignInVerificationEvent, SignInVerificationState> {
  final SignInUseCase signInUseCase;
  final GetProfileInformationUseCase getProfileInformationUseCase;

  SignInVerificationBloc({
    this.signInUseCase,
    this.getProfileInformationUseCase,
  }) : super(SignInVerificationInitial());

  @override
  Stream<SignInVerificationState> mapEventToState(
    SignInVerificationEvent event,
  ) async* {
    if (event is SignIn) {
      try {
        yield ButtonLoading();
        await signInUseCase.execute(event.contactNumber, event.pin);
        Session session = await getProfileInformationUseCase.execute();

        if (session.user.role == "individual") {
          yield SignInSuccess(route: INDIVIDUAL_HOME_ROUTE);
        } else {
          yield SignInSuccess(route: ESTABLISHMENT_HOME_ROUTE);
        }
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield SignInFailure(error: errorhandler);
      } catch (e) {
        print(e);
        yield SignInFailure(error: e);
      }
    }
  }

  void onSignIn(String contactNumber, String pin) {
    add(SignIn(contactNumber: contactNumber, pin: pin));
  }
}
