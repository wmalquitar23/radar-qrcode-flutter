import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_id_event.dart';
part 'upload_id_state.dart';

class UploadIdBloc extends Bloc<UploadIdEvent, UploadIdState> {
  UploadIdBloc() : super(UploadIdInitial());

  @override
  Stream<UploadIdState> mapEventToState(
    UploadIdEvent event,
  ) async* {
    if (event is OnSelectingImage) {
      yield UploadSelectingImageSuccess(event.selectedImage);
    }

    if (event is UploadIDOnView) {
      yield state.copyWith(selectedImage: event.selectedImage);
    }
  }
}
