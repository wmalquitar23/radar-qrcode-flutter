import 'package:radar_qrcode_flutter/data/mappers/check_in_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:sembast/sembast.dart';

import '../database.dart';

class CheckInDb extends Db {
  CheckInMapper _checkInMapper = CheckInMapper();

  CheckInDb(Database db)
      : super(
          db,
          intMapStoreFactory.store("checkin_queue"),
        );

  Stream<List<CheckIn>> listenForCheckIn() {
    var finder = Finder(
      filter: Filter.and([
        Filter.equals("hasUploaded", false),
      ]),
    );
    var query = store.query(finder: finder);
    return query.onSnapshots(db).map((snapshots) {
      return snapshots
          .map(
            (snapshot) => _checkInMapper.fromMap(snapshot.value),
          )
          .toList();
    });
  }

  Stream<List<CheckIn>> listenForTotalCheckIn() {
    var query = store.query();
    return query.onSnapshots(db).map((snapshots) {
      return snapshots
          .map(
            (snapshot) => _checkInMapper.fromMap(snapshot.value),
          )
          .toList();
    });
  }

  Future<List<CheckIn>> getAllData() async {
    var finder = Finder(
      filter: Filter.and([
        Filter.equals("hasUploaded", false),
      ]),
    );

    var query = await store.find(db, finder: finder);
    return query
        .map((snapshot) => _checkInMapper.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<void> saveList(List<dynamic> activities) async {
    for (Map<String, dynamic> activity in activities) {
      await this.save(activity);
    }
  }

  Future<void> save(Map<String, dynamic> activity) async {
    await db.transaction((txn) async {
      int key = await store.add(txn, activity);
      await store.update(txn, {'key': key});
    });
  }

  Future<void> updateData(int key) async {
    var finder = Finder(
      filter: Filter.equals("key", key),
    );
    await store.update(db, {'hasUploaded': true}, finder: finder);
  }
}
