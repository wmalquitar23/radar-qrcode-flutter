import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';

abstract class RapidPassContactRepository {
  Future<RapidPassContact> getRapidPassContact();
}
