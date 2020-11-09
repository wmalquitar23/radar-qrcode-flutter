import 'package:radar_qrcode_flutter/core/utils/string_util.dart';
import 'package:radar_qrcode_flutter/data/local_db/queue/check_in_queue_db.dart';
import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:intl/intl.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  Database db;
  RestClient restClient;
  SessionDb sessionDb;
  CheckInDb checkInDb;

  DateFormat dateFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");

  TransactionsRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
    checkInDb = CheckInDb(db);
  }

  Future<void> checkIn(
    User user,
    bool hasConnection, {
    String accessType = IN,
    DateTime dateTime,
  }) async {
    String isoDate = dateTime.toIso8601String();
    if (hasConnection) {
      await checkInDb.save({
        "user": UserMapper().toMap(user),
        "dateTime": isoDate,
        "hasUploaded": true,
        "accessLogType": accessType,
      });
      await restClient.checkIn(
        user.id,
        accessType,
        dateTime: isoDate,
      );
    } else {
      await checkInDb.save({
        "user": UserMapper().toMap(user),
        "dateTime": isoDate,
        "hasUploaded": false,
        "accessLogType": accessType,
      });
    }
  }

  Future<void> syncCheckInData() async {
    List<CheckIn> localdata = await checkInDb.getAllData();

    await Future.forEach(localdata, (CheckIn data) async {
      await restClient.checkIn(data.user.id, data.accessLogType,
          dateTime: data.dateTime);
      await checkInDb.updateData(data.key);
    });
  }

  @override
  Stream<List<CheckIn>> listenForCheckIn() {
    return checkInDb.listenForCheckIn();
  }

  @override
  Stream<List<CheckIn>> listenForTotalCheckIn() {
    return checkInDb.listenForTotalCheckIn();
  }
}
