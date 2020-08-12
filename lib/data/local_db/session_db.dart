import 'dart:async';
import 'package:radar_qrcode_flutter/data/mappers/session_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

import 'database.dart';

class SessionDb extends Db {
  SessionMapper sessionMapper = SessionMapper();

  SessionDb(Database db) : super(db, stringMapStoreFactory.store("session"));

  RecordRef get currentSessionRecord => store.record("main");

  Future<Session> getCurrentSession() async {
    Map<String, dynamic> value = await currentSessionRecord.get(db) as Map;
    return sessionMapper.fromMap(cloneMap(value));
  }

  Stream<Session> listenForSession() {
    return currentSessionRecord.onSnapshot(db).map((snapshot) {
      return sessionMapper.fromMap(snapshot?.value as Map);
    });
  }

  Future<void> save(Map<String, dynamic> session) async {
    await currentSessionRecord.put(db, session);
  }

  Future<void> delete() async {
    await currentSessionRecord.delete(db);
  }
}
