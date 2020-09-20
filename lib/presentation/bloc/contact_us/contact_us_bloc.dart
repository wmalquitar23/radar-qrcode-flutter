import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_rapidpass_contact_use_case.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final GetRapidPassContactUseCase getRapidPassContactUseCase;
  ContactUsBloc({this.getRapidPassContactUseCase}) : super(ContactUsInitial());

  @override
  Stream<ContactUsState> mapEventToState(
    ContactUsEvent event,
  ) async* {
    if (event is GetRapidPassContact) {
      yield ContactUsGetDataInProgress();

      final rapidPassContact = await getRapidPassContactUseCase.execute();

      yield ContactUsGetDataDone(rapidPassContact);
    }
  }
}
