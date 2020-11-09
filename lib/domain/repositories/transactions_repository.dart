import 'package:radar_qrcode_flutter/core/utils/string_util.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

abstract class TransactionsRepository {
  Future<void> checkIn(
    User id,
    bool hasConnection, {
    String accessType = IN,
    DateTime dateTime,
  });

  Future<void> syncCheckInData();

  Future<List<CheckIn>> getCheckinOfflineData();

  Stream<List<CheckIn>> listenForCheckIn();

  Stream<List<CheckIn>> listenForTotalCheckIn();
}
