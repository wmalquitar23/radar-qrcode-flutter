part of 'my_qrcode_bloc.dart';

abstract class MyQRCodeEvent extends Equatable {
  const MyQRCodeEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends MyQRCodeEvent {}

class UserOnLoad extends MyQRCodeEvent {}

class OnDownloadButtonClick extends MyQRCodeEvent {
  final QRDownloadType downloadType;
  final String qrData;
  final User user;
  final BuildContext buildContext;

  OnDownloadButtonClick({
    @required this.downloadType,
    @required this.qrData,
    @required this.user,
    @required this.buildContext,
  });

  @override
  List<Object> get props => [downloadType, user, qrData, buildContext];
}
