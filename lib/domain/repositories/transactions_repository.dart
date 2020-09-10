

import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

abstract class TransactionsRepository {
  Future<void> checkIn(User id, bool hasConnection);

  Future<void> syncCheckInData();

  Stream<List<CheckIn>> listenForCheckIn();
}
