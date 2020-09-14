part of 'verification_id_bloc.dart';

abstract class VerificationIdEvent extends Equatable {
  const VerificationIdEvent();

  @override
  List<Object> get props => [];
}

class VerificationIdOnUpload extends VerificationIdEvent {
  final File image;

  VerificationIdOnUpload(this.image);

  @override
  List<Object> get props => [image];
}
