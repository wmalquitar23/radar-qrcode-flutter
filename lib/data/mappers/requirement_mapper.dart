import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/requirement.dart';

class RequirementMapper extends RadarMapper<Requirement> {
  @override
  Requirement fromMap(Map<String, dynamic> map) {
    return map != null
        ? Requirement(
            isSubmitted: map["isSubmitted"],
            id: map["_id"],
          )
        : null;
  }

  @override
  Map<String, dynamic> toMap(Requirement object) {
    return null;
  }
}
