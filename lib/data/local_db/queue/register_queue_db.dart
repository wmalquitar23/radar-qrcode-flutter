import 'package:sembast/sembast.dart';

import '../database.dart';

class RegisterQueueDb extends Db {
  RegisterQueueDb(Database db)
      : super(db, stringMapStoreFactory.store("register_queue"));
  RecordRef get currentDataRecord => store.record("registrationData");

  Future<dynamic> getRegistrationData() async {
    return await currentDataRecord.get(db) as Map;
  }

  Future<void> save(Map<String, dynamic> data) async {
    await currentDataRecord.put(db, data);
  }
}
