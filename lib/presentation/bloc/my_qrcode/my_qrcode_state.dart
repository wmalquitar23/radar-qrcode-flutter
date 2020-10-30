part of 'my_qrcode_bloc.dart';

class MyQRCodeState extends Equatable {
  final bool getUserInProgress;
  final GetUserSuccess getUserSuccess;
  final String getUserSuccessMessage;
  final String getuserFailureMessage;

  const MyQRCodeState({
    this.getUserInProgress,
    this.getUserSuccess,
    this.getUserSuccessMessage,
    this.getuserFailureMessage,
  });

  @override
  List<Object> get props => [
        getUserInProgress,
        getUserSuccess,
        getUserSuccessMessage,
        getuserFailureMessage
      ];

  factory MyQRCodeState.copyWith(
    MyQRCodeState state, {
    bool getUserInProgress,
    GetUserSuccess getUserSuccess,
    String getUserSuccessMessage,
    String getuserFailureMessage,
  }) {
    return MyQRCodeState(
      getUserInProgress: getUserInProgress ?? state.getUserInProgress,
      getUserSuccess: getUserSuccess ?? state.getUserSuccess,
      getUserSuccessMessage: getUserSuccessMessage ?? null,
      getuserFailureMessage: getuserFailureMessage ?? null,
    );
  }
}

class MyQRCodeInitial extends MyQRCodeState {}

class GetUserSuccess extends MyQRCodeState {
  final User user;
  final String jsonQrCode;

  const GetUserSuccess({this.user, this.jsonQrCode});

  @override
  List<Object> get props => [user, jsonQrCode];
}

enum QRDownloadType { poster, sticker }

extension QRownloadTypeExtension on QRDownloadType {
  String get name => describeEnum(this);

  String get getValue {
    switch (this) {
      case QRDownloadType.poster:
        return "poster";
      case QRDownloadType.sticker:
        return "sticker";
      default:
        return null;
    }
  }
}
