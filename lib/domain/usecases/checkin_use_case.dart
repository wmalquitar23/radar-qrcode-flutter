import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';

class CheckInUseCase {
  final TransactionsRepository repository;

  CheckInUseCase(this.repository);

  Future<void> execute(String id) async {
    return await repository.checkIn(id);
  }
}
