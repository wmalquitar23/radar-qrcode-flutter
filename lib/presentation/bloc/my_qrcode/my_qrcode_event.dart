part of 'my_qrcode_bloc.dart';

abstract class MyQRCodeEvent extends Equatable {
  const MyQRCodeEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends MyQRCodeEvent {}

class UserOnLoad extends MyQRCodeEvent {}

class OnDownloadButtonClick extends MyQRCodeEvent {}
