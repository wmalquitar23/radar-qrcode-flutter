import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';

class RapidPassContactMapper extends RadarMapper<RapidPassContact> {
  @override
  RapidPassContact fromMap(Map<String, dynamic> map) {
    return map != null
        ? RapidPassContact(
            mobileNumber: map["mobile"] ?? "Not Available",
            emailAddress: map["email"] ?? "Not Available",
          )
        : null;
  }

  @override
  Map<String, dynamic> toMap(RapidPassContact object) {
    return object != null
        ? {
            "mobile": object?.mobileNumber,
            "email": object?.emailAddress,
          }
        : null;
  }
}
