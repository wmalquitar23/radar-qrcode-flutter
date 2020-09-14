part of 'upload_id_bloc.dart';

abstract class UploadIdEvent extends Equatable {
  const UploadIdEvent();

  @override
  List<Object> get props => [];
}

class OnSelectingImage extends UploadIdEvent {
  final File selectedImage;

  OnSelectingImage(this.selectedImage);
}

class UploadIDOnView extends UploadIdEvent {
  final File selectedImage;

  UploadIDOnView(this.selectedImage);
}

class OnUploadID extends UploadIdEvent {}
