import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/verification.dart';
import 'package:intl/intl.dart';

class VerificationMapper extends RadarMapper<Verification> {
  DateFormat dateFormatter = DateFormat("yyyy-MM-dd");
  @override
  Verification fromMap(Map<String, dynamic> map) {
    return map != null
        ? Verification(
            isVerified: map["isVerified"],
            date: map['date'] != null
                ? dateFormatter.parse(map['date'])
                : null,
            expirationDate: map['expirationDate'] != null
                ? dateFormatter.parse(map['expirationDate'])
                : null,
          )
        : null;
  }

  @override
  Map<String, dynamic> toMap(Verification object) {
    return null;
  }
}
