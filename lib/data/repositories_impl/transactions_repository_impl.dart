import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';
import 'package:sembast/sembast.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  Database db;
  RestClient restClient;
  SessionDb sessionDb;

  TransactionsRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
  }

  Future<void> checkIn(String id) async {
    await restClient.checkIn(id);
  }
}
