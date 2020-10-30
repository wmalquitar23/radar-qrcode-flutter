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

  DateFormat dateFormatter = DateFormat("yyyy-MM-dd");

  TransactionsRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
    checkInDb = CheckInDb(db);
  }

  Future<void> checkIn(User user, bool hasConnection) async {
    if (hasConnection) {
      await checkInDb.save({
        "user": UserMapper().toMap(user),
        "dateTime": dateFormatter.format(DateTime.now()),
        "hasUploaded": true,
      });
      await restClient.checkIn(user.id);
    } else {
      await checkInDb.save({
        "user": UserMapper().toMap(user),
        "dateTime": dateFormatter.format(DateTime.now()),
        "hasUploaded": false,
      });
    }
  }

  Future<void> syncCheckInData() async {
    List<CheckIn> localdata = await checkInDb.getAllData();

    await Future.forEach(localdata, (CheckIn data) async {
      await restClient.checkIn(data.user.id, dateTime: data.dateTime);
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
