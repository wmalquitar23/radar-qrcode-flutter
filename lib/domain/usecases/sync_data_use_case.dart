import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';

class SyncDataUseCase {
  final TransactionsRepository repository;

  SyncDataUseCase(this.repository);

  Future<void> execute() async {
    return await repository.syncCheckInData();
  }
}
