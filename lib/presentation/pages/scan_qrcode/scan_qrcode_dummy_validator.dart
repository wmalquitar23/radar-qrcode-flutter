import 'package:radar_qrcode_flutter/data/models/qr_code.dart';

class QRValidationResult {
  bool isResultAvailable;
  QRCode qrData;
  QRValidationResult({
    this.isResultAvailable = false,
    this.qrData,
  });
}

Stream<QRValidationResult> dummyQRValidation(String qrData) async* {
  yield QRValidationResult();

  await Future.delayed(Duration(seconds: 1));

  /// User found Scenario
  yield QRValidationResult(
    isResultAvailable: true,
    qrData: QRCode(
      userID: 1,
      firstName: "Jonel Dominic",
      lastName: "Tapang",
      address: "Cebu City",
      age: 22,
      isVerified: true,
    ),
  );

  /// User not found Scenario
  // yield QRValidationResult(
  //   isResultAvailable: true,
  //   qrData: null,
  // );
}