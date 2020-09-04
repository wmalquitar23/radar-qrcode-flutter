import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/error_handler.dart';
import 'package:radar_qrcode_flutter/domain/usecases/update_pin_use_case.dart';

part 'change_pin_event.dart';
part 'change_pin_state.dart';

class ChangePinBloc extends Bloc<ChangePinEvent, ChangePinState> {
  final UpdatePINUseCase updatePINUseCase;
  ChangePinBloc({this.updatePINUseCase}) : super(ChangePinInitial());

  @override
  Stream<ChangePinState> mapEventToState(
    ChangePinEvent event,
  ) async* {
    if (event is OnSaveNewPIN) {
      yield ChangePINLoading();
      try {
        if (event.newPIN == null ||
            event.oldPIN == null ||
            event.confirmPIN == null) {
          throw Exception("Fill up all fields");
        } else if (event.newPIN != event.confirmPIN) {
          throw Exception("You PIN does not match");
        }
        await updatePINUseCase.execute(event.oldPIN, event.newPIN);
        yield ChangePINSuccess();
      } on DioError catch (e) {
        String errorhandler = ErrorHandler().dioErrorHandler(e);
        yield ChangePINFailure(error: errorhandler);
      } catch (e) {
        yield ChangePINFailure(error: e.message);
      }
    }
  }
}
