part of 'upload_id_bloc.dart';

class UploadIdState extends Equatable {
  final File selectedImage;
  final bool uploadImageLoading;
  final bool uploadImageSuccess;
  final bool uploadImageFailure;
  const UploadIdState({
    this.selectedImage,
    this.uploadImageLoading = false,
    this.uploadImageSuccess = false,
    this.uploadImageFailure = false,
  });

  UploadIdState copyWith({
    File selectedImage,
    bool uploadImageLoading,
    bool uploadImageSuccess,
    bool uploadImageFailure,
  }) {
    return UploadIdState(
      selectedImage: selectedImage,
      uploadImageLoading: uploadImageFailure ?? false,
      uploadImageFailure: uploadImageFailure ?? false,
      uploadImageSuccess: uploadImageSuccess ?? false,
    );
  }

  @override
  List<Object> get props => [
        selectedImage,
        uploadImageLoading,
        uploadImageSuccess,
        uploadImageFailure,
      ];
}

class UploadIdInitial extends UploadIdState {}

class UploadSelectingImageFailure extends UploadIdState {}

class UploadSelectingImageSuccess extends UploadIdState {
  final File selectedimage;

  UploadSelectingImageSuccess(this.selectedimage);
}

class UploadImageInitial extends UploadIdState {}

class UploadImageLoading extends UploadIdState {}

class UploadImageSuccess extends UploadIdState {}
